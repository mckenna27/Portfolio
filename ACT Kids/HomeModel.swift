//
//  HomeModel.swift
//  ACT Kids
//
//  Created by Patrick E. McKenna on 4/8/18.
//  Copyright © 2018 Patrick McKenna. All rights reserved.
//

import Foundation

protocol HomeModelProtocol: class
{
    func itemsDownloaded(items: NSArray)
}

class HomeModel: NSObject, URLSessionDataDelegate
{
    // Properties
    weak var delegate: HomeModelProtocol!
    var data = Data()
    let urlPath: String = "http://yourapproadmap.com/service.php" // This will be changed to the path where service php resides
    func downloadItems() {
        
        let url: URL = URL(string: urlPath)!
        let defaultSession = Foundation.URLSession(configuration: URLSessionConfiguration.default)
        
        let task = defaultSession.dataTask(with: url) { (data, response, error) in
            
            if error != nil {
                print("Failed to download data")
            }else {
                print("Data downloaded")
                self.parseJSON(data!)
            }
            
        }
        
        task.resume()
    }
    
    func parseJSON(_ data:Data) {
        
        var jsonResult = NSArray()
        
        do{
            jsonResult = try JSONSerialization.jsonObject(with: data, options:JSONSerialization.ReadingOptions.allowFragments) as! NSArray
            
        } catch let error as NSError {
            print(error)
            
        }
        
        var jsonElement = NSDictionary()
        let locations = NSMutableArray()
        
        for i in 0 ..< jsonResult.count
        {
            
            jsonElement = jsonResult[i] as! NSDictionary
            
            let location = LocationModel()
            
            //the following insures none of the JsonElement values are nil through optional binding
            if let MyID = jsonElement["My ID"] as? String,
                let CurrPts = jsonElement["Current Points"] as? String,
                let GoalPts = jsonElement["My Points Goal"] as? String,
                let PtsToGoal = jsonElement["Points remaining to my goal"] as? String
            {
                
                location.MyID = MyID
                location.CurrPts = CurrPts
                location.GoalPts = GoalPts
                location.PtsToGoal = PtsToGoal
                
            }
            
            locations.add(location)
            
        }
        
        DispatchQueue.main.async(execute: { () -> Void in
            
            self.delegate.itemsDownloaded(items: locations)
            
        })
    }
    
}


