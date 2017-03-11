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
    
    
    //function to save last searched city in userdefault
    static func saveSearchedCity(value: String?){
        let defaults = UserDefaults.standard
        defaults.set(value, forKey: "CITY");
        defaults.synchronize()

    }
    
    //function to get city from userdefault
    
    static func getLastSearchedCity()-> String?{
        let defaults = UserDefaults.standard
        return defaults.string(forKey: "CITY");
    }
    
    //Convert Milliseconds to hours & minute
    
//    func stringFromTimeInterval(interval: TimeInterval) -> NSString {
//        
//        let ti = NSInteger(interval)
//        
//        let ms = Int((interval % 1) * 1000)
//        
//        let seconds = ti % 60
//        let minutes = (ti / 60) % 60
//        let hours = (ti / 3600)
//        
//        return NSString(format: "%0.2d:%0.2d:%0.2d.%0.3d",hours,minutes,seconds,ms)
//    }
    
}
