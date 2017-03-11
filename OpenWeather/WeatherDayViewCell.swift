//
//  WeatherViewCell.swift
//  OpenWeather
//
//  Created by Karthikeyan Gopal on 3/10/17.
//  Copyright © 2017 Karthikeyan Gopal. All rights reserved.
//

import UIKit

class WeatherDayViewCell: UITableViewCell {
    
    @IBOutlet weak var keyLabel: UILabel!
    
    @IBOutlet weak var valueLabel: UILabel!
    


    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
