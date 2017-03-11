//
//  WeatherInfo.swift
//  OpenWeather
//
//  Created by Karthikeyan Gopal on 3/11/17.
//  Copyright © 2017 Karthikeyan Gopal. All rights reserved.
//

import Foundation

// Class for load weather in tableview

class WeatherInfo{
    
    
    var info : String?
    var value : String?
    
    init(info:String, value:String) {
        self.info = info
        self.value = value
    }
    
}
