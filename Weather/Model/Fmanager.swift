//
//  FManager.swift
//  Weather
//
//  Created by Frantisek Varadzin on 19/11/2020.
//

import UIKit

protocol FManagerDelegate {
    func didUpdateForecast(_ forecastManager: FManager, forecast: FModel)
    func didFailWithError(error: Error)
    
}


struct FManager {
    let forecastURL = "https://api.openweathermap.org/data/2.5/forecast?appid=1513074b04afcac9adc59f2ce25f6755&units=metric&q=london"

    var delegate: FManagerDelegate?
    
    func fetchForecast(cityName: String) {
        let urlString = "\(forecastURL)&q=\(cityName)"
        performForcastRequest(with: urlString)
    }
    
    func performForcastRequest(with urlString: String) {
        if let url = URL(string: urlString) {
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) { (data, response, error) in
                if error !=  nil {
                    self.delegate?.didFailWithError(error: error!)
                    return
                }
                if let safeData = data {
                    if let forecast = self.parseJSON(safeData) {
                        self.delegate?.didUpdateForecast(self, forecast: forecast)
                    }
                }
            }
            task.resume()
        }
    }
    
    
    func parseJSON(_ forecastData: Data) -> FModel? {
        let decoder = JSONDecoder()
        
        do {
            let decodedData = try decoder.decode(FData.self, from: forecastData)
            let temp = decodedData.main.temp
            let name
        }
    }
    
    
}
