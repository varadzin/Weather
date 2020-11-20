//
//  FData.swift
//  Weather
//
//  Created by Frantisek Varadzin on 20/11/2020.
//

import Foundation

struct FData: Codable {
    let list:[List]
    let city: City
    
}
struct List: Codable {
    
    let main: Main
    let dt: Int
    let weather: [Weather]
    
}

struct Main: Codable {
    let temp: Double
}

struct Weather: Codable {

let icon: String
}

struct City: Codable {
    let name: String
}

