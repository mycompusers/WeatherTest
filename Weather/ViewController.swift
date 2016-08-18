//
//  ViewController.swift
//  Weather
//
//  Created by Archita Bansal on 8/15/16.
//  Copyright © 2016 iOS Meetup. All rights reserved.
//

import UIKit

class ViewController: UIViewController,AddDetailsDelegate,UITableViewDelegate,UITableViewDataSource {

    @IBOutlet weak var weatherTableView: UITableView!
//    var weatherInfoList = [WeatherInfo]()
    var weatherList = [[String:String]]()
    //MARK: VIEW CONTROLLER METHODS

    
    override func viewDidLoad() {
        super.viewDidLoad()
        let prefs = NSUserDefaults.standardUserDefaults()
        if let valuee = prefs.valueForKey("WeatherInfo")
        {
            weatherList = valuee as! Array
        }
        //weatherInfoList = (prefs.valueForKey("WeatherInfo")?)!
        self.weatherTableView.dataSource = self
        self.weatherTableView.delegate = self
        self.weatherTableView.rowHeight = 55.0
        self.weatherTableView.separatorStyle = .SingleLine
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(ViewController.colorUpdated(_:)) , name:"color_updated", object: nil)
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    func colorUpdated(notification:NSNotification) {
        let userInfo:Dictionary<String,AnyObject!> = notification.userInfo as! Dictionary<String,AnyObject!>
        let color : UIColor = userInfo["color"] as! UIColor
        
        let indexPaths = self.weatherTableView.indexPathsForVisibleRows;
        for ip in indexPaths!{
            let cell = self.weatherTableView.cellForRowAtIndexPath(ip)
            cell?.backgroundColor = color
        }
    }
    
    override func viewWillAppear(animated: Bool) {
        
        self.title = "Indian Cities Temperatures"
    }
    
    //MARK: ACTION METHODS
    
    @IBAction func onAdd(sender: UIBarButtonItem) {
        
        
        self.performSegueWithIdentifier("showDetail", sender: self)
        
        /*let controller = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("addDetail") as! AddDetailViewController
        controller.addDetailsDelegate = self
        self.navigationController?.pushViewController(controller, animated: true)*/
        
    }

    
    func detailsAdded(city: String, temp: String) {

        let weatherDict  = ["City":city, "Temperature":temp]
        
        weatherList.append(weatherDict)

        self.weatherTableView.reloadData()
        
        let prefs = NSUserDefaults.standardUserDefaults()
        prefs.setValue(weatherList, forKey: "WeatherInfo");
        prefs.synchronize()
    }

    
    //MARK: TABLEVIEW DATASOURCE
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
     func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            weatherList.removeAtIndex(indexPath.row)
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
        }
    }
    
    func tableView(tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return UIView(frame: CGRect.zero)
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 80.0
    }
    
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return weatherList.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath)
        
        let cellFont = UIFont(name:"Arial", size:25)
        
        cell.textLabel?.font  = cellFont
        cell.detailTextLabel?.font  = cellFont
        
        if (indexPath.row % 2 == 1) {
            cell.backgroundColor = UIColor.lightGrayColor()
        }

        cell.textLabel?.text  = weatherList[indexPath.row]["City"]
        cell.detailTextLabel?.text = weatherList[indexPath.row]["Temperature"]

//        cell.textLabel?.text  = self.weatherInfoList[indexPath.row].cityName
//        cell.detailTextLabel?.text = self.weatherInfoList[indexPath.row].cityTemperature
        
        cell.selectionStyle = .None
        return cell
    }
    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
       
        if(segue.identifier == "showDetail")
        {
            let destinationVC:AddDetailViewController = segue.destinationViewController as! AddDetailViewController
            destinationVC.firstVC = self;
            
        }
    }

}

/*extension ViewController : UITableViewDelegate,UITableViewDataSource{
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return UIView(frame: CGRect.zero)
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 80.0
    }
    
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.cityTemperature.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath)
        
        let cellFont = UIFont(name:"Arial", size:25)
        
        cell.textLabel?.font  = cellFont
        cell.detailTextLabel?.font  = cellFont

        
        cell.textLabel?.text  = self.cityNames[indexPath.row]
        cell.detailTextLabel?.text = self.cityTemperature[indexPath.row]

        cell.selectionStyle = .None
        return cell
    }
    
    
    
}
*/
