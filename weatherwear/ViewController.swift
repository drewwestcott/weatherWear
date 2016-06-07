//
//  ViewController.swift
//  weatherwear
//
//  Created by Drew Westcott on 03/06/2016.
//  Copyright © 2016 Drew Westcott. All rights reserved.
//

import UIKit
import Alamofire

class ViewController: UIViewController {
    
    //api.openweathermap.org/data/2.5/weather?lat=50.8185081&lon=-1.0880&APPID=f1bf763bc9d0c2a6374722d80fd8e9b4
    let baseURL = "http://api.openweathermap.org/data/2.5/"
    let apiKey = "f1bf763bc9d0c2a6374722d80fd8e9b4"

    @IBOutlet weak var background: UIImageView!
    @IBOutlet weak var windSpeedLabel: UILabel!
    @IBOutlet weak var barometerLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        let blurEffect = UIBlurEffect(style: UIBlurEffectStyle.Light)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = background.bounds
        blurEffectView.autoresizingMask = [.FlexibleWidth, .FlexibleHeight] // for supporting device rotation
        
        // Vibrancy Effect
        let vibrancyEffect = UIVibrancyEffect(forBlurEffect: blurEffect)
        let vibrancyEffectView = UIVisualEffectView(effect: vibrancyEffect)
        vibrancyEffectView.frame = view.bounds
        
//        vibrancyEffectView.contentView.addSubview(barometerLabel)
//        blurEffectView.contentView.addSubview(vibrancyEffectView)

        background.addSubview(blurEffectView)
        
        updateCurrentWeather("-1.0880", latitude: "50.81850")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    func updateCurrentWeather(longitude: String, latitude: String) {
        
        let locationURL = "\(baseURL)weather?lat=\(longitude)&lon=\(latitude)&APPID=\(apiKey)"
        let url = NSURL(string: locationURL)!
        
        Alamofire.request(.GET, url).responseJSON { response in
            print(response.request)  // original URL request
            print(response.response) // URL response
            print(response.data)     // server data
            print(response.result)   // result of response serialization
        }
    }
}

