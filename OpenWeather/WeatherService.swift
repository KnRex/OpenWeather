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
    
    
    // Service to get weather deatails for particulat city
    
    func getWeatherForCity(city: String,  successHandler:@escaping (WeatherDetail)-> Void) {
        
        // This is a pretty simple networking task, so the shared session will do.
        let config = URLSessionConfiguration.default
        let session = URLSession(configuration: config)
        let weatherRequestURL = URL(string: "\(openWeatherMapBaseURL)?APPID=\(openWeatherMapAPIKey)&q=\(city)")!
        
        let task = session.dataTask(with: weatherRequestURL, completionHandler: {
            (data, response, error) in
            
            if error != nil {
                print(error!.localizedDescription)
            } else {
                do {
                    
                    if let json = try JSONSerialization.jsonObject(with: data!, options: .allowFragments) as? [String: Any]
                    {
                        //Implement your logic
                        let weatherDetail = WeatherDetail.init(dictionary: json as NSDictionary)
                        print(weatherDetail!.weather![0].description!)
                        successHandler(weatherDetail!)
                     
                        
                    }
                    
                } catch {
                    
                    print("error in JSONSerialization")
                    
                }
            }
            
        })
        task.resume()
    }
    
}
