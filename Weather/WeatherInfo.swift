//
//  WeatherInfo.swift
//  Weather
//
//  Created by Parminder Singh on 8/17/16.
//  Copyright © 2016 iOS Meetup. All rights reserved.
//

import Foundation

class WeatherInfo: NSObject {
    var cityName : String
    var cityTemperature : String
    
    init(name : String, temperature : String) {
        cityName = name
        cityTemperature = temperature
    }
}