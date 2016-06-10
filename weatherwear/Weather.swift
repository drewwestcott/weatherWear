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
    
    var place: String {
        return _place
    }
    var longitude: String {
        return _longitude
    }
    var latitude: String {
        return _latitude
    }
    
    init(longitude: String, latitude: String) {
        self._longitude = longitude
        self._latitude = latitude
    }
    
    func updateCurrentWeather(completed: DownloadComplete) {
        
        print("reached update function")
        let locationURL = "\(baseURL)weather?lat=\(self._latitude)&lon=\(self._longitude)&APPID=\(apiKey)"
        let url = NSURL(string: locationURL)!
        
        Alamofire.request(.GET, url).responseJSON { response in
            let result = response.result
            
            if let dict = result.value as? Dictionary<String, AnyObject> {
                
                if let place = dict["name"] as? String {
                    self._place = place
                    print(place)
                } else {
                    self._place = "Location Unavailable"
                }
            }
        }
    }

}
