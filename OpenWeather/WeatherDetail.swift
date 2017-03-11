/*
Copyright (c) 2017 Swift Models Generated from JSON powered by http://www.json4swift.com

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
*/

import Foundation
 
/* For support, please feel free to contact me at https://www.linkedin.com/in/syedabsar */

public class WeatherDetail {
	public var coord : Coord?
	public var weather : Array<Weather>?
	public var base : String?
	public var main : Main?
	public var visibility : Int?
	public var wind : Wind?
	public var clouds : Clouds?
	public var dt : Int?
	public var sys : Sys?
	public var id : Int?
	public var name : String?
	public var cod : Int?

/**
    Returns an array of models based on given dictionary.
    
    Sample usage:
    let json4Swift_Base_list = Json4Swift_Base.modelsFromDictionaryArray(someDictionaryArrayFromJSON)

    - parameter array:  NSArray from JSON dictionary.

    - returns: Array of Json4Swift_Base Instances.
*/
    public class func modelsFromDictionaryArray(array:NSArray) -> [WeatherDetail]
    {
        var models:[WeatherDetail] = []
        for item in array
        {
            models.append(WeatherDetail(dictionary: item as! NSDictionary)!)
        }
        return models
    }

/**
    Constructs the object based on the given dictionary.
    
    Sample usage:
    let json4Swift_Base = Json4Swift_Base(someDictionaryFromJSON)

    - parameter dictionary:  NSDictionary from JSON.

    - returns: Json4Swift_Base Instance.
*/
	required public init?(dictionary: NSDictionary) {

		if (dictionary["coord"] != nil) { coord = Coord(dictionary: dictionary["coord"] as! NSDictionary) }
		if (dictionary["weather"] != nil) { weather = Weather.modelsFromDictionaryArray(array: dictionary["weather"] as! NSArray) }
		base = dictionary["base"] as? String
		if (dictionary["main"] != nil) { main = Main(dictionary: dictionary["main"] as! NSDictionary) }
		visibility = dictionary["visibility"] as? Int
		if (dictionary["wind"] != nil) { wind = Wind(dictionary: dictionary["wind"] as! NSDictionary) }
		if (dictionary["clouds"] != nil) { clouds = Clouds(dictionary: dictionary["clouds"] as! NSDictionary) }
		dt = dictionary["dt"] as? Int
		if (dictionary["sys"] != nil) { sys = Sys(dictionary: dictionary["sys"] as! NSDictionary) }
		id = dictionary["id"] as? Int
		name = dictionary["name"] as? String
		cod = dictionary["cod"] as? Int
	}

		
/**
    Returns the dictionary representation for the current instance.
    
    - returns: NSDictionary.
*/
	public func dictionaryRepresentation() -> NSDictionary {

		let dictionary = NSMutableDictionary()

		dictionary.setValue(self.coord?.dictionaryRepresentation(), forKey: "coord")
		dictionary.setValue(self.base, forKey: "base")
		dictionary.setValue(self.main?.dictionaryRepresentation(), forKey: "main")
		dictionary.setValue(self.visibility, forKey: "visibility")
		dictionary.setValue(self.wind?.dictionaryRepresentation(), forKey: "wind")
		dictionary.setValue(self.clouds?.dictionaryRepresentation(), forKey: "clouds")
		dictionary.setValue(self.dt, forKey: "dt")
		dictionary.setValue(self.sys?.dictionaryRepresentation(), forKey: "sys")
		dictionary.setValue(self.id, forKey: "id")
		dictionary.setValue(self.name, forKey: "name")
		dictionary.setValue(self.cod, forKey: "cod")

		return dictionary
	}

}
