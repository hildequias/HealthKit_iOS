//
//  WorkoutsTableViewController.swift
//  HKTutorial
//
//  Created by ernesto on 18/10/14.
//  Copyright (c) 2014 raywenderlich. All rights reserved.
//

import UIKit
import HealthKit

public enum DistanceUnit:Int {
  case miles=0, kilometers=1
}

open class WorkoutsTableViewController: UITableViewController {
  
  let kAddWorkoutReturnOKSegue = "addWorkoutOKSegue"
  let kAddWorkoutSegue  = "addWorkoutSegue"
  
  var distanceUnit = DistanceUnit.miles
  var healthManager:HealthManager?
  
  // MARK: - Formatters
  lazy var dateFormatter:DateFormatter = {
    
    let formatter = DateFormatter()
    formatter.timeStyle = .short
    formatter.dateStyle = .medium
    return formatter;
    
    }()
  
  let durationFormatter = DateComponentsFormatter()
  let energyFormatter = EnergyFormatter()
  let distanceFormatter = LengthFormatter()
  
  // MARK: - Class Implementation
  
  open override func viewDidLoad() {
    super.viewDidLoad()
    
    self.clearsSelectionOnViewWillAppear = false
    
  }
  
  open override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    
  }
  
  open override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    
    if( segue.identifier == kAddWorkoutSegue )
    {
      
      if let addViewController:AddWorkoutTableViewController = segue.destinationViewController.topViewController as? AddWorkoutTableViewController {
        addViewController.distanceUnit = distanceUnit
      }
    }
    
  }
  
  @IBAction func unitsChanged(_ sender:UISegmentedControl) {
    
    distanceUnit  = DistanceUnit(rawValue: sender.selectedSegmentIndex)!
    tableView.reloadData()
    
  }
  
  // MARK: - Segues
  @IBAction func unwindToSegue (_ segue : UIStoryboardSegue) {
    
    if( segue.identifier == kAddWorkoutReturnOKSegue )
    {
      print("TODO: Save workout in Health Store")
    }
    
  }
  
}
