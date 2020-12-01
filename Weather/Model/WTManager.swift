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
                    if let weather = self.parseJSON(safeData) {
                        self.delegate?.didUpdateWeather(self, weather: weather)
                    }
                }
            }
            task.resume()
        }
    }
    
    func parseJSON(_ weatherData: Data) -> WTModel? {
        let decoder = JSONDecoder()
        
        do {
            //actual Weather - main screen
            let decodedData = try decoder.decode(WTData.self, from: weatherData)
            let temp = decodedData.list[0].main.temp
            let name = decodedData.city.name
            let description = decodedData.list[0].weather[0].description
            let speed = decodedData.list[0].wind.speed
            let icon = decodedData.list[0].weather[0].icon
            
            
            
            //Weather forecast - small images
            
            let FCicon1 = decodedData.list[2].weather[0].icon
            let FCtemp1 = decodedData.list[2].main.temp
            let FCicon2 = decodedData.list[4].weather[0].icon
            let FCtemp2 = decodedData.list[4].main.temp
            let FCicon3 = decodedData.list[6].weather[0].icon
            let FCtemp3 = decodedData.list[6].main.temp
            let FCicon4 = decodedData.list[8].weather[0].icon
            let FCtemp4 = decodedData.list[8].main.temp
            let weather = WTModel(weatherDescription: description, cityName: name, temperature: temp, windSpeed: speed, weatherIcon: icon,
                                  forecastIcon1: FCicon1, forecastTemp1: FCtemp1,
                                  forecastIcon2: FCicon2, forecastTemp2: FCtemp2,
                                  forecastIcon3: FCicon3, forecastTemp3: FCtemp3,
                                  forecastIcon4: FCicon4, forecastTemp4: FCtemp4)
            return weather
        } catch {
            delegate?.didFailWithError(error: error)
            return nil
            
        }
    }
}


