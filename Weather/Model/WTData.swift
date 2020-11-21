//
//  WTData.swift
//  Weather
//
//  Created by Frantisek Varadzin on 01/11/2020.
//

import Foundation

struct WTData: Codable {
    
    let time: Date
    

    
    let speed: Double
    let temp:Double
    
    let icon: String
    let description: String
    let name: String
    
}


    


/*
 FORECAST
 
 {
     "cod": "200",
     "message": 0,
     "cnt": 40,
     "list": [
         {
             "dt": 1605906000,
             "main": {
                 "temp": 10.27,
                 "feels_like": 6.5,
                 "temp_min": 10.24,
                 "temp_max": 10.27,
                 "pressure": 1030,
                 "sea_level": 1030,
                 "grnd_level": 1027,
                 "humidity": 88,
                 "temp_kf": 0.03
             },
             "weather": [
                 {
                     "id": 804,
                     "main": "Clouds",
                     "description": "overcast clouds",
                     "icon": "04n"
                 }
             ],
             "clouds": {
                 "all": 95
             },
             "wind": {
                 "speed": 4.85,
                 "deg": 237
             },
             "visibility": 10000,
             "pop": 0,
             "sys": {
                 "pod": "n"
             },
             "dt_txt": "2020-11-20 21:00:00"
         },
 
 WEATHER
 
 {
     "coord": {
         "lon": -0.13,
         "lat": 51.51
     },
     "weather": [
         {
             "id": 804,
             "main": "Clouds",
             "description": "overcast clouds",
             "icon": "04n"
         }
     ],
     "base": "stations",
     "main": {
         "temp": 10.3,
         "feels_like": 7.02,
         "temp_min": 10,
         "temp_max": 11,
         "pressure": 1030,
         "humidity": 87
     },
     "visibility": 10000,
     "wind": {
         "speed": 4.1,
         "deg": 230
     },
     "clouds": {
         "all": 90
     },
     "dt": 1605903167,
     "sys": {
         "type": 1,
         "id": 1414,
         "country": "GB",
         "sunrise": 1605857262,
         "sunset": 1605888305
     },
     "timezone": 0,
     "id": 2643743,
     "name": "London",
     "cod": 200
 }
 
 
 
 struct WTData: Codable {
     
     let list: [List]
 }
     
 struct List: Codable {
     
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


 
 
 
 */
