//
//  FCData.swift
//  Weather
//
//  Created by Frantisek Varadzin on 23/11/2020.
//

import Foundation

struct FCData: Codable  {
    var list: [WeatherConditions]
 
}


struct WeatherConditions: Codable  {
    var main: WeatherDetail
    var weather: [WeatherDetail2]
    var dt_txt: String
    
}

struct WeatherDetail: Codable {
    var temp: Double
}


struct WeatherDetail2: Codable {
    var icon: String
}

    
/*
 
 {
     "cod": "200",
     "message": 0,
     "cnt": 40,
     "list": [
         {
             "dt": 1606057200,
             "main": {
                 "temp": 10.72,
                 "feels_like": 7.68,
                 "temp_min": 10.49,
                 "temp_max": 10.72,
                 "pressure": 1026,
                 "sea_level": 1026,
                 "grnd_level": 1023,
                 "humidity": 61,
                 "temp_kf": 0.23
             },
             "weather": [
                 {
                     "id": 803,
                     "main": "Clouds",
                     "description": "broken clouds",
                     "icon": "04d"
                 }
             ],
             "clouds": {
                 "all": 81
             },
             "wind": {
                 "speed": 2.33,
                 "deg": 290
             },
             "visibility": 10000,
             "pop": 0,
             "sys": {
                 "pod": "d"
             },
             "dt_txt": "2020-11-22 15:00:00"
         },
 
 
 
 ...
 
 
 ],
     "city": {
         "id": 2643743,
         "name": "London",
         "coord": {
             "lat": 51.5085,
             "lon": -0.1257
         },
         "country": "GB",
         "population": 1000000,
         "timezone": 0,
         "sunrise": 1606030257,
         "sunset": 1606060972
     }
 }
 */
