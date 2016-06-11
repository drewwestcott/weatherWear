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
    
    @IBOutlet weak var background: UIImageView!
    @IBOutlet weak var windSpeedLabel: UILabel!
    @IBOutlet weak var barometerLabel: UILabel!
    @IBOutlet weak var placeLabel: UILabel!
        
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
        
        //vibrancyEffectView.contentView.addSubview(barometerLabel)
        //blurEffectView.contentView.addSubview(vibrancyEffectView)

        background.addSubview(blurEffectView)
        
        let weather = WeatherReport(longitude: "-1.0880", latitude: "50.81850")
        print("Report requested")
        weather.updateCurrentWeather { () -> () in
            self.updateUI()
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func updateUI() {
        print("updateUI called")
        windSpeedLabel.text = "4.94 SW"
    }

}

