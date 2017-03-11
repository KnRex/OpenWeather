
//
//  WeatherService.swift
//  OpenWeather
//
//  Created by Karthikeyan Gopal on 3/11/17.
//  Copyright © 2017 Karthikeyan Gopal. All rights reserved.
//

import Foundation


class WeatherService {
    
    private let openWeatherMapBaseURL = "http://api.openweathermap.org/data/2.5/weather"
    private let openWeatherMapAPIKey = "5fad988ce5de1a276142e4ea733ebedc"
    
    
    // This function calls open weather api for weather info. 
    // Completion handler for failure & success callback
    
    func getWeatherForCity(city: String,  completionHandler:@escaping (WeatherDetail?, String?)-> Void) {
        
        // This is a pretty simple networking task, so the shared session will do.
        let config = URLSessionConfiguration.default
        let session = URLSession(configuration: config)
        let weatherRequestURL = URL(string: "\(openWeatherMapBaseURL)?APPID=\(openWeatherMapAPIKey)&q=\(city)")!
        
        let task = session.dataTask(with: weatherRequestURL, completionHandler: {
            (data, response, error) in
            
            if error != nil {
                print(error!.localizedDescription)
                completionHandler(nil,error!.localizedDescription);
            } else {
                do {
                    
                    if let json = try JSONSerialization.jsonObject(with: data!, options: .allowFragments) as? [String: Any]
                    {
                        let response = json as NSDictionary
                        
                        var responseCode:Int?
                        
                        if  response.value(forKey: "cod") is String {
                            responseCode = Int(response.value(forKey: "cod")as! String);
                        }
                        else{
                            
                            responseCode = response.value(forKey: "cod")as? Int
                        }
                        
                        
                        if responseCode! == 200 {
                            let weatherDetail = WeatherDetail.init(dictionary: json as NSDictionary)
                            
                            
                            DispatchQueue.main.async() { () -> Void in
                                completionHandler(weatherDetail!,nil)
                            }
                        }
                        else{
                            DispatchQueue.main.async() { () -> Void in
                                print(response)
                            completionHandler(nil,response.value(forKey: "message")as? String)
                            }
                        }
                     
                    }
                    
                } catch {
                    
                    print("error in JSONSerialization")
                    
                }
            }
            
        })
        task.resume()
    }
    
}
