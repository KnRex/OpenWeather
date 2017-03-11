//
//  ViewController.swift
//  OpenWeather
//
//  Created by Karthikeyan Gopal on 3/10/17.
//  Copyright © 2017 Karthikeyan Gopal. All rights reserved.
//

import UIKit
import CoreLocation

class WeatherViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, CLLocationManagerDelegate {
    
    
    @IBOutlet weak var cityLabel: UILabel!

    @IBOutlet weak var weatherIconView: UIImageView!
    
    @IBOutlet weak var weatherTemp: UILabel!
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var descriptionLabel: UILabel!
    
    var locationManager: CLLocationManager = CLLocationManager()
    
    var tableViewData = [WeatherInfo]()
    
    //MARK: ViewController Delegates
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.delegate = self
        locationManager.distanceFilter = kCLLocationAccuracyHundredMeters;
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()

        
    }

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    func getWeatherForCity(city: String){
        let weatherService = WeatherService()
        weatherService.getWeatherForCity(city: city){
            (result: WeatherDetail?, error:String?) in
            if  error == nil{
                self.updateWeatherInfo(result: result)
            }
            else{
                let alert = UIAlertController(title: "Alert", message:error!, preferredStyle: UIAlertControllerStyle.alert)
                alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
                self.present(alert, animated: true, completion: nil)
            }
        };
        
    }
    
    
    //MARK: UITableView Delegates
    
    private func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String?{
        return "Today Weather Condition"
    }
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.tableViewData.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! WeatherDayViewCell
        
        let weatherInfo = tableViewData[indexPath.row]
        
        cell.keyLabel.text = weatherInfo.info! + " : "
        cell.valueLabel.text = weatherInfo.value
        
        return cell;
    }
    
    // Update weather info to the screen
    func updateWeatherInfo(result : WeatherDetail?){
        let sunrise =  WeatherInfo(info: "Sunrise", value: String(result!.sys!.sunrise!))
        let sunset =  WeatherInfo(info: "Sunset", value: String(result!.sys!.sunset!))
        let humidity = WeatherInfo(info: "Humidity", value:String(result!.main!.humidity!))
        let pressure = WeatherInfo(info: "Pressure", value:String(result!.main!.pressure!))
        let windSpeed = WeatherInfo(info: "Wind Speed", value: String(result!.wind!.speed!))
        
        self.tableViewData.append(sunrise)
        self.tableViewData.append(sunset)
        self.tableViewData.append(humidity)
        self.tableViewData.append(pressure)
        self.tableViewData.append(windSpeed)
        self.tableView.reloadData()
        descriptionLabel.text =  result!.weather![0].description!
        weatherTemp.text = CommonUtils.convertKelvinToFarenheit(value: result!.main!.temp!)
        self.downloadImage(imageName: result!.weather![0].icon!)
        
    }
    
    
    // method to download Image and display it
    
    func downloadImage(imageName: String) {
        let url = URL(string : "http://openweathermap.org/img/w/\(imageName).png")
        DataService().getDataFromUrl(url: url!) { (data, response, error)  in
            guard let data = data, error == nil else { return }
            print(response?.suggestedFilename ?? url?.lastPathComponent as Any)
            print("Download Finished")
            DispatchQueue.main.async() { () -> Void in
                self.weatherIconView.image = UIImage(data: data)
            }
           
        }
    }
    
    //MARK: Location Delegates
    
    // First fetch city from location corodinates to display weather information
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let geoCoder = CLGeocoder()
        let lastLocation: CLLocation = locations[locations.count - 1]
        self.locationManager.stopUpdatingLocation()
        geoCoder.reverseGeocodeLocation(lastLocation)
        {
            (placemarks, error) -> Void in
            
            if let error = error{
                print("Unable to Reverse Geocode Location (\(error))")

            }
            else{
            let placeArray = placemarks as [CLPlacemark]!
            
            // Place details
            var placeMark: CLPlacemark!
            placeMark = placeArray?[0]
        
            // City
            if let city = placeMark.addressDictionary?["City"] as? NSString
            {
                print(city)
                self.getWeatherForCity(city: city as String)
            }
            
            // Zip code
            if let zip = placeMark.addressDictionary?["ZIP"] as? NSString
            {
                print(zip)
            }
        }
           
    }
        
    }
    

}

