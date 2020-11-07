//
//  WTModel.swift
//  Weather
//
//  Created by Frantisek Varadzin on 01/11/2020.
//

import Foundation

struct WTModel {
    
    let weatherDescription: String
    let cityName: String
    let temperature: Double
    let windSpeed: Double
    let weatherIcon: String
    
    var temperatureString: String {
        return String(format: "%.1f", temperature)
    }
    
    var windSpeedString: String {
        return String(format: "%.1f", windSpeed)
    }
    
    
    
    
}
