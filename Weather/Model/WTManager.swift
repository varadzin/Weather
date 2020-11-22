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
    var resourseURL: URL
    
//
//    let weatherURL = "https://api.openweathermap.org/data/2.5/forecast?appid=1513074b04afcac9adc59f2ce25f6755&units=metric"
//
    // forecast: https://api.openweathermap.org/data/2.5/forecast?appid=1513074b04afcac9adc59f2ce25f6755&units=metric&q=london
    var delegate: WTManagerDelegate?
    
    func fetchWeather(cityName: String) {
    
       
        let resourceString = "https://api.openweathermap.org/data/2.5/forecast?appid=1513074b04afcac9adc59f2ce25f6755&units=metric&q=\(cityName)"
        
        guard let resourceURL = URL(string: resourceString) else { fatalError()}
        

       
       func performRequest( {
        
        
        
        
        
//           if let url = URL(string: urlString) {
//               let session =  URLSession(configuration: .default)
//               let task = session.dataTask(with: url) { (data, response, error) in
//                   if error != nil {
//                       self.delegate?.didFailWithError(error: error!)
//                       return
//                   }
//                   if let safeData = data {
//                       if let weather = self.parseJSON(safeData) {
//                           self.delegate?.didUpdateWeather(self, weather: weather)
//                       }
//                   }
//               }
//               task.resume()
//           }
//       }
//
       func parseJSON(_ weatherData: Data) -> WTModel? {
           let decoder = JSONDecoder()
           
           do {
               let decodedData = try decoder.decode(lists.self, from: weatherData)
        
            let temp = decodedData.list.main.temp
            let name = decodedData.list.name
            let description = decodedData.list.weather.description
            let speed = decodedData.list.wind.speed
            let icon = decodedData.list.weather.icon
            
            let weather = WTModel(weatherDescription: description, cityName: name, temperature: temp, windSpeed: speed, weatherIcon: icon)
            
            return weather
        } catch {
            delegate?.didFailWithError(error: error)
            return nil
            
        }
    }
}
