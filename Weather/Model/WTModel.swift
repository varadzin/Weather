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
    
    let forecastIcon1: String
    let forecastTemp1: Double

    let forecastIcon2: String
    let forecastTemp2: Double
    
    let forecastIcon3: String
    let forecastTemp3: Double
    
    let forecastIcon4: String
    let forecastTemp4: Double


    var forecastTemperature1: String {
        return String(format: "%.1f", forecastTemp1)
    }
   

    var forecastTemperature2: String {
        return String(format: "%.1f", forecastTemp2)
    }
    var forecastTemperature3: String {
        return String(format: "%.1f", forecastTemp3)
    }
    var forecastTemperature4: String {
        return String(format: "%.1f", forecastTemp4)
    }
    
    
    
    var temperatureString: String {
        return String(format: "%.1f", temperature)
    }
    
    var windSpeedString: String {
        return String(format: "%.1f", windSpeed)
    }
    
}


