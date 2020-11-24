//
//  FCModel.swift
//  Weather
//
//  Created by Frantisek Varadzin on 24/11/2020.
//

import Foundation

struct FCModel {
    
    let forecastDay: String
    let forecastIcon: String
    let forecastTemp: Double
    
    

    var forecastTemperature: String {
        return String(format: "%.1f", forecastTemp)
    }


}
