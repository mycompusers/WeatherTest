//
//  WeatherGetter.swift
//  SimpleWeather
//
//  Created by Joey deVilla on 4/6/16.
//  MIT license. See the end of this file for the gory details.
//
//  Accompanies the article in Global Nerdy (http://globalnerdy.com):
//  "How to build an iOS weather app in Swift, part 1: 
//  A very bare-bones weather app"
//  http://www.globalnerdy.com/2016/04/02/how-to-build-an-ios-weather-app-in-swift-part-1-a-very-bare-bones-weather-app/
//


import Foundation

class WeatherGetter {
  
  private let openWeatherMapBaseURL = "http://api.openweathermap.org/data/2.5/weather"
  private let openWeatherMapAPIKey = "2888f31517116a36aa1bc0c976f27aec"
    
    

  
  func getWeather(city: String) {
    
    // This is a pretty simple networking task, so the shared session will do.
    let session = NSURLSession.sharedSession()
    
    let weatherRequestURL = NSURL(string: "\(openWeatherMapBaseURL)?APPID=\(openWeatherMapAPIKey)&q=\(city)")!
    
    // The data task retrieves the data.
    let dataTask = session.dataTaskWithURL(weatherRequestURL) {
      (data: NSData?, response: NSURLResponse?, error: NSError?) in
      if let error = error {
        // Case 1: Error
        // We got some kind of error while trying to get data from the server.
        print("Error:\n\(error)")
      }
      else {
        // Case 2: Success
        // We got a response from the server!
        print("Raw data:\n\(data!)\n")
        if let data = data
        {

            let dataString = String(data: data, encoding: NSUTF8StringEncoding)
            print("Human-readable data:\n\(dataString!)")
            self.extractData1(data)
            
        }
      }
    }
    
    // The data task is set up...launch it!
    dataTask.resume()
  }
  
    func extractData1(weatherData: NSData) {
        let json = try? NSJSONSerialization.JSONObjectWithData(weatherData, options: []) as! NSDictionary
        
        if json != nil {
            if let name = json!["name"] as? String {
                //location.text = name
                print("City Name \(name)")
            }
            
            if let main = json!["main"] as? NSDictionary {
                if let temp = main["temp"] as? Double {
                    //temperature.text = String(format: "%.0f", temp)
                    let temp2 = temp - 273.15;
                    print("Temperature: \(String(format: "%.0f", temp2)) C")
                    NSNotificationCenter.defaultCenter().postNotificationName("CityTemperature", object: nil, userInfo: ["value":"\(String(format: "%.0f", temp2))"])
                    
                }
            }
        }
    }
}


// This code is released under the MIT license.
// Simply put, you're free to use this in your own projects, both
// personal and commercial, as long as you include the copyright notice below.
// It would be nice if you mentioned my name somewhere in your documentation
// or credits.
//
// MIT LICENSE
// -----------
// (As defined in https://opensource.org/licenses/MIT)
//
// Copyright © 2016 Joey deVilla. All rights reserved.
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), 
// to deal in the Software without restriction, including without limitation 
// the rights to use, copy, modify, merge, publish, distribute, sublicense, 
// and/or sell copies of the Software, and to permit persons to whom 
// the Software is furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included 
// in all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, 
// EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES 
// OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. 
// IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, 
// DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, 
// TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE 
// OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.