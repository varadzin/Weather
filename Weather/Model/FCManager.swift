//
//  FCManager.swift
//  Weather
//
//  Created by Frantisek Varadzin on 23/11/2020.
//

import UIKit


enum DataError: Error {
    case noDataAvailable
    case canNotProcessData
    
}

protocol FCManagerDelegate {
    func didUpdateForecast(_ forecastManager: FCManager, forecast: FCModel)
    func didFailWithError2(error: Error)
}

struct FCManager {

let forecastURL = "https://api.openweathermap.org/data/2.5/forecast?appid=1513074b04afcac9adc59f2ce25f6755&units=metric"


var delegate: FCManagerDelegate?

func fetchForecast(cityName: String) {
    let urlString = "\(forecastURL)&q=\(cityName)"
    performFCRequest(with: urlString)
}

func performFCRequest(with urlString: String) {
    if let url = URL(string: urlString) {
        let session =  URLSession(configuration: .default)
        let task = session.dataTask(with: url) { (data, response, error) in
            if error != nil {
                self.delegate?.didFailWithError2(error: error!)
                return
            }
            if let safeData = data {
                if let forecast = self.parse2JSON(safeData) {
                    self.delegate?.didUpdateForecast(self, forecast: forecast)
                }
            }
        }
        task.resume()
    }
}

func parse2JSON(_ forecastData: Data) -> FCModel? {
    let decoder = JSONDecoder()
    
    do {
        let decodedData = try decoder.decode(FCData.self, from: forecastData)
      
        let FCday = "day"
        let FCicon = decodedData.list[0].weather[0].icon
        let FCtemp = decodedData.list[0].main.temp
        let forecast = FCModel(forecastDay: FCday, forecastIcon: FCicon, forecastTemp: FCtemp)
        
        
        print(FCicon, FCtemp)
        return forecast
    } catch {
        delegate?.didFailWithError2(error: error)
        return nil
        
    }
}

}







//
//struct FCManager {
//    let resourceURL: URL
//    let API_KEY = "1513074b04afcac9adc59f2ce25f6755"
//
//    init (cityName: String) {
//
//      let resourceString = "https://api.openweathermap.org/data/2.5/forecast?appid=\(API_KEY)&units=metric&q=\(cityName)"
//
//        guard let resourceURL = URL(string: resourceString) else { fatalError() }
//        self.resourceURL = resourceURL
//        var delegate: FCManagerDelegate?
//
//    }
//
//    func getForecast (completion: @escaping(Result<[WeatherConditions], DataError>) -> Void) {
//        let dataTask = URLSession.shared.dataTask(with: resourceURL) {data, _, _ in
//            guard let jsonData = data else {
//                completion(.failure(.noDataAvailable))
//            return
//            }
//
//            do {
//                let decoder = JSONDecoder()
//                let weatherResponse = try decoder.decode(WeatherAllConditions.self, from: jsonData)
//                let weatherDetails = weatherResponse.list
//                completion(.success(weatherDetails))
//            } catch {
//                completion(.failure(.canNotProcessData))
//            }
//
//
//
//        }
//        dataTask.resume()
//    }
//
//
//}
