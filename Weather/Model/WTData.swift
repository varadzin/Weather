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
//    let id: Int
}

struct Wind: Codable {
    let speed: Double
}





/*
 
 {
     "coord": {
         "lon": -0.13,
         "lat": 51.51
     },
     "weather": [
         {
             "id": 500,
             "main": "Rain",
             "description": "light rain",
             "icon": "10d"
         }
     ],
     "base": "stations",
     "main": {
         "temp": 15.86,
         "feels_like": 11.44,
         "temp_min": 15,
         "temp_max": 17,
         "pressure": 1002,
         "humidity": 72
     },
     "visibility": 9000,
     "wind": {
         "speed": 6.7,
         "deg": 230
     },
     "rain": {
         "1h": 0.52
     },
     "clouds": {
         "all": 75
     },
     "dt": 1604242557,
     "sys": {
         "type": 1,
         "id": 1414,
         "country": "GB",
         "sunrise": 1604213674,
         "sunset": 1604248411
     },
     "timezone": 0,
     "id": 2643743,
     "name": "London",
     "cod": 200
 }
 
 
 */
