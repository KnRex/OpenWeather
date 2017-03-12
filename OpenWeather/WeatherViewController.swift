//
//  ViewController.swift
//  OpenWeather
//
//  Created by Karthikeyan Gopal on 3/10/17.
//  Copyright © 2017 Karthikeyan Gopal. All rights reserved.
//

import UIKit
import CoreLocation


class WeatherViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, CLLocationManagerDelegate, UISearchBarDelegate {
    
    // UI elements
    
    @IBOutlet weak var cityLabel: UILabel!

    @IBOutlet weak var weatherIconView: UIImageView!
    
    @IBOutlet weak var weatherTemp: UILabel!
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var descriptionLabel: UILabel!
    
    @IBOutlet weak var searchField: UISearchBar!
    
    //Location Manager
    
    var locationManager: CLLocationManager = CLLocationManager()
    
    
    var tableViewData = [WeatherInfo]()
    
    //MARK: ViewController Delegates
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.delegate = self
        tableView.dataSource = self
        searchField.delegate = self
        
        tableView.backgroundColor = UIColor.clear
        tableView.backgroundView?.backgroundColor = UIColor.clear
        
        if(CommonUtils.getLastSearchedCity()==nil){
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.delegate = self
        locationManager.distanceFilter = kCLLocationAccuracyHundredMeters;
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        }
        else{
            getWeatherForCity(city: CommonUtils.getLastSearchedCity()!)
        }
        
    }

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    
    
    //MARK: UITableView Delegates
    
    private func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String?{
        return "Today's Weather Condition"
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let vw = UILabel(frame:CGRect(x: 20, y: 0, width: 320, height: 320))
        vw.font = UIFont(name:"HelveticaNeue", size: 18.0)
        vw.backgroundColor = UIColor.clear
        vw.textColor = UIColor.white
        vw.text = "   Today's Weather Condition"
        return vw
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.tableViewData.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! WeatherDayViewCell
        cell.contentView.backgroundColor = UIColor .clear
        
        
        let weatherInfo = tableViewData[indexPath.row]
        
        cell.keyLabel.text = weatherInfo.info!
        cell.valueLabel.text = weatherInfo.value
        
        return cell;
    }
    
    // Update weather information for the city
    func updateWeatherInfo(result : WeatherDetail?){
        
        self.tableViewData.removeAll()
        self.tableView.reloadData()
        CommonUtils.saveSearchedCity(value: result!.name!)
        
  
        
        if(result!.sys!.sunrise != nil){
            
            let sunrise =  WeatherInfo(info: "Sunrise", value: CommonUtils.stringFromMilliseconds(interval: result!.sys!.sunrise!) as String)
            self.tableViewData.append(sunrise)

        }
  
    

        
        if(result!.sys!.sunset != nil){
            let sunset =  WeatherInfo(info: "Sunset", value: CommonUtils.stringFromMilliseconds(interval:
                result!.sys!.sunset!) as String)
            self.tableViewData.append(sunset)

        }
        
    
        
        if(result!.main!.humidity != nil){
             let humidityValue = String(result!.main!.humidity!) + "%"
            let humidity = WeatherInfo(info: "Humidity", value: humidityValue)
            self.tableViewData.append(humidity)

        }
        
        
        
        if(result!.main!.pressure != nil){
            let pressureValue = String(result!.main!.pressure!) + " hPa"
            let pressure = WeatherInfo(info: "Pressure", value:pressureValue)
            self.tableViewData.append(pressure)

        }
        
        
        
        if(result!.wind!.speed != nil){
            let windSpeedValue = String(result!.wind!.speed!) + " km/hr"
            let windSpeed = WeatherInfo(info: "Wind Speed", value: windSpeedValue)
            self.tableViewData.append(windSpeed)

        }
        
        
        if(result!.visibility != nil){
         let visibilityValue = String(result!.visibility!) + " km"
            let visibility = WeatherInfo(info: "Visibility", value: visibilityValue)
            self.tableViewData.append(visibility)
        }
        
        
        self.tableView.reloadData()
        descriptionLabel.text =  result!.weather![0].description!
        let temperature = CommonUtils.convertKelvinToFarenheit(value: result!.main!.temp!) + "\u{00B0}" + " F / " + ""+CommonUtils.convertKelvinToCelsius(value: result!.main!.temp!) + "\u{00B0}" + " C ";
            
        weatherTemp.text = temperature
        self.downloadImage(imageName: result!.weather![0].icon!)
        
        cityLabel.text = result!.name!;
        
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
    
    
    //MARK: SearchBar Delegates
   
    
    public func searchBarSearchButtonClicked(_ searchBar: UISearchBar){
        print(searchBar.text!)
       self.getWeatherForCity(city: searchBar.text!)
        
    }
    
    
    
    //MARK: Location Delegates
    
    // First time fetch city from location corodinates to display weather information
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
    
    
    //This function calls api to get the weather report. Throws alert incase of error.
    
    func getWeatherForCity(city: String){
        let weatherService = WeatherService()
        weatherService.getWeatherForCity(city: city){
            (result: WeatherDetail?, error:String?) in
            if  error == nil{
                if(result!.cod==200){
                    self.updateWeatherInfo(result: result)
                }
            }
            else{
                DispatchQueue.main.async() { () -> Void in
                    let myAlert = UIAlertView()
                    myAlert.title = "Alert!"
                    myAlert.message = error!
                    myAlert.addButton(withTitle: "Ok")
                    myAlert.delegate = self
                    myAlert.show()
                    
                }
            }
        };
        
    }

    
    
    

}

