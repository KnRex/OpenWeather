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
    
    static func stringFromMilliseconds(interval: Int) -> String {
        
        let date = NSDate(timeIntervalSince1970: TimeInterval(interval))
        
        print(date)
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "hh:mm a"
        let timeZone = TimeZone.ReferenceType.system
        dateFormatter.timeZone = timeZone as TimeZone!
//        let calendar = Calendar.current
//        let comp = calendar.dateComponents([.hour, .minute], from: date as Date)
//        let hour = dateFormatter.hour
//        let minute = comp.minute
        
        let hour = dateFormatter.string(from: date as Date)
       
        return hour
    }
    
}
