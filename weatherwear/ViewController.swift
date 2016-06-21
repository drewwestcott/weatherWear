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
    @IBOutlet weak var accessoryImage: UIImageView!
    @IBOutlet weak var windSpeedLabel: UILabel!
    @IBOutlet weak var barometerLabel: UILabel!
    @IBOutlet weak var placeLabel: UILabel!
    @IBOutlet weak var updatedLabel: UILabel!
    
    var weather: WeatherReport!
    
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
        
        weather = WeatherReport(longitude: "-1.0880", latitude: "50.81850")
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
        placeLabel.text = weather.place
        windSpeedLabel.text = "\(weather.windSpeed) 🎏"
        if weather.pressure != -1 {
            barometerLabel.text = "\(weather.pressure) 🕰"
            barometerLabel.hidden = false
        } else {
            barometerLabel.hidden = true
        }
        
        switch weather.accessory {
        case .umbrella:
            print("Need an umbrella")
            accessoryImage.image = UIImage(named: "umbrella")
        default:
            print("Sun glasses or just a smile")
            accessoryImage.image = UIImage(named: "glasses")
        }
        let updatedAt = NSDate()
        let updatedAndFormatted = NSDateFormatter.localizedStringFromDate(updatedAt, dateStyle: .NoStyle, timeStyle: .ShortStyle)
        updatedLabel.text = updatedAndFormatted
    }

}

