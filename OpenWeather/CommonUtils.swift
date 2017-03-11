//
//  CommonUtils.swift
//  OpenWeather
//
//  Created by Karthikeyan Gopal on 3/11/17.
//  Copyright © 2017 Karthikeyan Gopal. All rights reserved.
//

import Foundation

class CommonUtils{
    
    
    //function to convert kelvin to farenheit
    static func convertKelvinToFarenheit(value : Double?)->String{
        
       let temp =  (9/5)*(value! - 273) + 32
        return String((floor(temp)))
        
    }
    
    //function to convert farenheit to celsius
    
    static func convertKelvinToCelsius(value: Double?)->String{
        let temp =  value! - 273
        return String((floor(temp)))
    }
    
}
