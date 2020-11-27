//
//  WTData.swift
//  Weather
//
//  Created by Frantisek Varadzin on 01/11/2020.
//

import Foundation

struct WTData: Codable {
    
    let list: [List]
    let city: City
}

struct List: Codable {
    let main: Main
    let weather: [Weather]
    let wind: Wind
    let dt_txt: String
}

struct Main: Codable {
    let temp: Double
}

struct Weather: Codable {
    let icon: String
    let description: String
}

struct City: Codable {
    let name: String
}

struct Wind: Codable {
    let speed: Double
}
