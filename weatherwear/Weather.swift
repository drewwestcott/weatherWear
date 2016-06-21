//
//  Weather.swift
//  weatherwear
//
//  Created by Drew Westcott on 10/06/2016.
//  Copyright © 2016 Drew Westcott. All rights reserved.
//

import Foundation
import Alamofire

class WeatherReport {
    private var _longitude: String!
    private var _latitude: String!
    private var _place: String!
    private var _pressure: Int!
    private var _windSpeed: Double!
    private var _clothes: String!
    private var _accessory: Accessory!
    
    var place: String {
        return _place
    }
    var longitude: String {
        return _longitude
    }
    var latitude: String {
        return _latitude
    }
    var windSpeed: Double {
        return _windSpeed
    }
    var pressure: Int {
        return _pressure
    }
    enum Accessory {
        case umbrella
        case glasses
        case scarf
    }
    
    var accessory: Accessory {
        return _accessory
    }
    
    
    init(longitude: String, latitude: String) {
        self._longitude = longitude
        self._latitude = latitude
    }
    
    func updateCurrentWeather(completed: () -> () ) {
        
        print("Reached update function")
        let locationURL = "\(baseURL)weather?lat=\(self._latitude)&lon=\(self._longitude)&APPID=\(apiKey)"
        let url = NSURL(string: locationURL)!
        
        Alamofire.request(.GET, url).responseJSON { response in
            let result = response.result
            print(result)
            if let dict = result.value as? Dictionary<String, AnyObject> {
                debugPrint(dict)
                if let place = dict["name"] as? String {
                    self._place = place
                    print("Inside request:\(place)")
                } else {
                    self._place = "Location Unavailable"
                }
                
                if let wind = dict["wind"] as? Dictionary<String, AnyObject> {
                    if let speed = wind["speed"] as? Double {
                        self._windSpeed = speed
                        print("Speed:\(speed)")
                    }
                }
                
                if let main = dict["main"] as? Dictionary<String, AnyObject> {
                    if let pressure = main["pressure"] as? Int {
                        if pressure > 0 {
                            self._pressure = pressure
                            NSUserDefaults.standardUserDefaults().setObject(pressure, forKey: "pressure")
                            } else {
                            if let lastPressure = NSUserDefaults.standardUserDefaults().objectForKey("pressure") as? Int {
                                self._pressure = lastPressure
                            } else {
                                self._pressure = 0
                            }

                        }
                    }
                }
                
                if let condition = dict["weather"] as? [Dictionary<String, AnyObject>] where condition.count > 0 {
                    print("weather")
                    if let gear = condition[0]["main"] as? String {
                        print(gear)
                        switch (gear) {
                            case "Rain":
                            self._accessory = Accessory.umbrella
                            case "Clouds":
                            self._accessory = Accessory.scarf
                            case "Clear":
                            self._accessory = Accessory.glasses
                        default:
                            self._accessory = Accessory.glasses
                        }
                    }
                }
                
            }
            completed()
        }
        
    }

}