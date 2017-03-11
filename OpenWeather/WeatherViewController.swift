//
//  ViewController.swift
//  OpenWeather
//
//  Created by Karthikeyan Gopal on 3/10/17.
//  Copyright © 2017 Karthikeyan Gopal. All rights reserved.
//

import UIKit

class WeatherViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    
    @IBOutlet weak var cityLabel: UILabel!

    @IBOutlet weak var weatherIconView: UIImageView!
    
    @IBOutlet weak var weatherTemp: UILabel!
    
    @IBOutlet weak var tableView: UITableView!
    
    //MARK: ViewController Delegates
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        let weatherService = WeatherService()
        weatherService.getWeatherForCity(city: "Norwalk,ct"){
            (result: WeatherDetail!) in
            print("got back: \(result!.weather![0].description!)")
            
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
        return "Today Weather Condition"
    }
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! WeatherDayViewCell
        
        return cell;
    }
    

}

