//
//  AddDetailViewController.swift
//  Weather
//
//  Created by Archita Bansal on 8/16/16.
//  Copyright © 2016 iOS Meetup. All rights reserved.
//

import UIKit

protocol AddDetailsDelegate{
    func detailsAdded(city:String,temp:String)
}

class AddDetailViewController: UIViewController, SettingsColorChangeObserver{

    @IBOutlet weak var outletNextBtn: UIButton!
    @IBOutlet weak var txtTemperature: UITextField!
    @IBOutlet weak var temperature: UILabel!
    @IBOutlet weak var txtName: UITextField!
    
    weak var firstVC:ViewController?
   
    //var addDetailsDelegate : AddDetailsDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        self.temperature.text = "Sample data"
        self.title = "Add City / Temperature"
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(AddDetailViewController.colorUpdated(_:)) , name:"color_updated", object: nil)

        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(AddDetailViewController.updateTemperature(_:)) , name:"CityTemperature", object: nil)
        
    }
    
    func updateTemperature(notification:NSNotification) {
        let userInfo:Dictionary<String,String!> = notification.userInfo as! Dictionary<String,String!>
        let temperatureText:String = userInfo["value"] as String!
        //self.txtTemperature.text = temperatureText
        dispatch_async(dispatch_get_main_queue()) {
        self.temperature.text = "\(temperatureText) C"
        self.firstVC!.detailsAdded(self.txtName.text!, temp: self.temperature.text!)
        }
    }
    
    func colorUpdated(notification:NSNotification) {
        let userInfo:Dictionary<String,AnyObject!> = notification.userInfo as! Dictionary<String,AnyObject!>
        let color : UIColor = userInfo["color"] as! UIColor
        self.view.backgroundColor = color
    }
    


    @IBAction func onNext(sender: UIButton) {
        
//        if txtName.text != "" && txtTemperature.text != ""{
//            
//       // self.addDetailsDelegate?.detailsAdded(self.txtName.text!, temp: self.txtTemperature.text!)
//            
//          firstVC!.detailsAdded(self.txtName.text!, temp: self.txtTemperature.text!)
//            
//           self.navigationController?.popViewControllerAnimated(true)
//        }else{
//            
//            let alertController = UIAlertController(title: "" , message: "Please fill all the details", preferredStyle: .Alert)
//           
//            alertController.addAction(UIAlertAction(title: "Ok", style: .Default, handler: nil))
//            self.presentViewController(alertController, animated: true, completion: nil)
//
//        }
        self .getTemprature(sender)
    }
    
    @IBAction func getTemprature(sender: UIButton) {
        
        self.temperature.text = "Fetching..."
        if txtName.text != ""{
            
            let weather = WeatherGetter()
            weather.getWeather(txtName.text!)

            // self.addDetailsDelegate?.detailsAdded(self.txtName.text!, temp: self.txtTemperature.text!)
            //self.txtTemperature.text = "22"
            //firstVC!.detailsAdded(self.txtName.text!, temp: self.txtTemperature.text!)
            
            //self.navigationController?.popViewControllerAnimated(true)
        }else{
            
            let alertController = UIAlertController(title: "" , message: "City name cannot be nil.", preferredStyle: .Alert)
            
            alertController.addAction(UIAlertAction(title: "Ok", style: .Default, handler: nil))
            
            
            
            self.presentViewController(alertController, animated: true, completion: nil)
            
        }
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if(segue.identifier == "show_settings")
        {
            let settingsVC = segue.destinationViewController as! SettingsViewController
            settingsVC.colorDelegate = self;            
        }
    }
    
    func colorChanged(color: UIColor) {
        self.view.backgroundColor = color
    }
    
}

