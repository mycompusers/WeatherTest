//
//  SettingsColorChangeObserver.swift
//  Weather
//
//  Created by Parminder Singh on 8/17/16.
//  Copyright © 2016 iOS Meetup. All rights reserved.
//

import Foundation
import UIKit

protocol SettingsColorChangeObserver {
    func colorChanged(color:UIColor) -> Void
}