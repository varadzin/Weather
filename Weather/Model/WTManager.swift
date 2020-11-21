//
//  WTManager.swift
//  Weather
//
//  Created by Frantisek Varadzin on 01/11/2020.
//

import UIKit

protocol WTManagerDelegate {
    func didUpdateWeather(_ weatherManager: WTManager, weather: WTModel)
    func didFailWithError(error: Error)
}

struct WTManager {
    
    let weatherURL = "https://api.openweathermap.org/data/2.5/forecast?appid=1513074b04afcac9adc59f2ce25f6755&units=metric"
    
    // forecast: https://api.openweathermap.org/data/2.5/forecast?appid=1513074b04afcac9adc59f2ce25f6755&units=metric&q=london
    var delegate: WTManagerDelegate?
    
    func fetchWeather(cityName: String) {
        let urlString = "\(weatherURL)&q=\(cityName)"
        performRequest(with: urlString)
    }
    
    func performRequest(with urlString: String) {
        if let url = URL(string: urlString) {
            let session =  URLSession(configuration: .default)
            let task = session.dataTask(with: url) { (data, response, error) in
                if error != nil {
                    self.delegate?.didFailWithError(error: error!)
                    return
                }
                if let safeData = data {
                    if let weather = JSONDecodable(decoder: safeData) {
                        self.delegate?.didUpdateWeather(self, weather: weather)
                    }
                }
            }
            task.resume()
        }
    }
    
//    func parseJSON(_ weatherData: Data) -> WTModel? {
//        let decoder = JSONDecoder()
//
//        do {
//            let decodedData = try decoder.decode(WTData.self, from: weatherData)
//            let temp = decodedData.temp
//            let name = decodedData.name
//            let description = decodedData.description
//            let speed = decodedData.speed
//            let icon = decodedData.icon
//
//            let weather = WTModel(weatherDescription: description, cityName: name, temperature: temp, windSpeed: speed, weatherIcon: icon)
//
//            return weather
//        } catch {
//            delegate?.didFailWithError(error: error)
//            return nil
//
//        }
//    }
}
extension WTData: JSONDecodable {
    
    init(decoder: JSONDecoder) throws {
        self.icon = try decoder.decode(key: "icon")
        self.speed = try decoder.decode(key: "speed")
        self.description = try decoder.decode(key: "description")
        self.name = try decoder.decode(key: "name")
        self.temp = try decoder.decode(key: "temp")
        let time: Double = try decoder.decode(key: "dt")
                self.time = Date(timeIntervalSince1970: time)
    
    
    }
    
    
}
