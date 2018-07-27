//
//  LocationModel.swift
//  ACT Kids
//
//  Created by Patrick E. McKenna on 4/8/18.
//  Copyright © 2018 Patrick McKenna. All rights reserved.
//

import Foundation

class LocationModel: NSObject {
    
    // Properties
    var MyID: String?
    var CurrPts: String?
    var GoalPts: String?
    var PtsToGoal: String?
    
    // Empty Constructor
    override init()
    {
        
    }
    
    // Constructor with @MyID, @CurrPts, @GoalPts, @PtsToGoal parameters
    init(MyID: String, CurrPts: String, GoalPts: String, PtsToGoal: String)
    {
        self.MyID = MyID
        self.CurrPts = CurrPts
        self.GoalPts = GoalPts
        self.PtsToGoal = PtsToGoal
    }
    
    // Prints object's current state
    override var description: String {
        return "MyID: \(MyID)), CurrPts: \(CurrPts), GoalPts: \(GoalPts), PtsToGoal: \(PtsToGoal)"
    }
}
