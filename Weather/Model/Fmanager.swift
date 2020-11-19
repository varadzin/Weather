//
//  Fmanager.swift
//  Weather
//
//  Created by Frantisek Varadzin on 19/11/2020.
//

import UIKit

protocol FManagerDelegate {
    func didUpdateForecast(_ forecastManager: Fmanager, forecast: FModel)
    func didFailWithError(error: Error)
    
}


struct Fmanager {
    let forecastURL = "https://api.openweathermap.org/data/2.5/forecast?appid=1513074b04afcac9adc59f2ce25f6755&units=metric&q=london"

    var delegate: FManagerDelegate?
    
    func fetchForecast(cityName: String) {
        let urlString = "\(forecastURL)&q=\(cityName)"
        performForcastRequest(with: urlString)
    }
    
    func performForcastRequest(with urlString: String) {
        
    }
    
    
}
