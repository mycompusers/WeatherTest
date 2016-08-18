//
//  SettingsViewController.swift
//  Weather
//
//  Created by Parminder Singh on 8/17/16.
//  Copyright © 2016 iOS Meetup. All rights reserved.
//

import Foundation
import UIKit

class SettingsViewController: UIViewController {
    
    var colorDelegate : SettingsColorChangeObserver?

    @IBAction func blackColorButtonPressed(sender: AnyObject) {
        NSNotificationCenter.defaultCenter().postNotificationName("color_updated", object: nil, userInfo: ["color":UIColor.blackColor()])
    }
    
    @IBAction func blueColorButtonPressed(sender: AnyObject) {
        NSNotificationCenter.defaultCenter().postNotificationName("color_updated", object: nil, userInfo: ["color":UIColor.blueColor()])
    }
    
    @IBAction func redColorButtonPressed(sender: AnyObject) {
        NSNotificationCenter.defaultCenter().postNotificationName("color_updated", object: nil, userInfo: ["color":UIColor.redColor()])
    }
}

