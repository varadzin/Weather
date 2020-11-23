//
//  WTData.swift
//  Weather
//
//  Created by Frantisek Varadzin on 01/11/2020.
//

import Foundation

struct WTData: Codable {
    
    let name: String
    let main: Main
    let weather: [Weather]
    let wind: Wind
}

struct Main: Codable {
    let temp: Double
}

struct Weather: Codable {
    let description: String
    let icon: String
    let main: String
}

struct Wind: Codable {
    let speed: Double
}



