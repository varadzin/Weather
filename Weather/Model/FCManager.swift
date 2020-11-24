//
//  FCManager.swift
//  Weather
//
//  Created by Frantisek Varadzin on 23/11/2020.
//

import Foundation

enum DataError: Error {
    case noDataAvailable
    case canNotProcessData
    
}

protocol FCManagerDelegate {
    func didUpdateForecast(_ forecastManager: FCManager, forecast: FCModel)
    func didFailWithError2(error: Error)
}


struct FCManager {
    let resourceURL: URL
    let API_KEY = "1513074b04afcac9adc59f2ce25f6755"

    init (cityName: String) {
        
      let resourceString = "https://api.openweathermap.org/data/2.5/forecast?appid=\(API_KEY)&units=metric&q=\(cityName)"
        
        guard let resourceURL = URL(string: resourceString) else { fatalError() }
        self.resourceURL = resourceURL
        var delegate: FCManagerDelegate?
        
    }
    
    func getForecast (completion: @escaping(Result<[WeatherConditions], DataError>) -> Void) {
        let dataTask = URLSession.shared.dataTask(with: resourceURL) {data, _, _ in
            guard let jsonData = data else {
                completion(.failure(.noDataAvailable))
            return
            }
            
            do {
                let decoder = JSONDecoder()
                let weatherResponse = try decoder.decode(WeatherAllConditions.self, from: jsonData)
                let weatherDetails = weatherResponse.list
                completion(.success(weatherDetails))
            } catch {
                completion(.failure(.canNotProcessData))
            }
            
            
            
        }
        dataTask.resume()
    }
    
    
}
