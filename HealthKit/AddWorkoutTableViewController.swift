//
//  AddWorkoutTableViewController.swift
//  HKTutorial
//
//  Created by ernesto on 18/10/14.
//  Copyright (c) 2014 raywenderlich. All rights reserved.
//

import UIKit

class AddWorkoutTableViewController: UITableViewController {
  
  
  
  @IBOutlet var dateCell:DatePickerCell!
  @IBOutlet var startTimeCell:DatePickerCell!
  
  @IBOutlet var durationTimeCell:NumberCell!
  @IBOutlet var caloriesCell:NumberCell!
  @IBOutlet var distanceCell:NumberCell!
  
  
  let kSecondsInMinute=60.0
  let kDefaultWorkoutDuration:TimeInterval=(1.0*60.0*60.0) // One hour by default
  let lengthFormatter = LengthFormatter()
  var distanceUnit = DistanceUnit.miles
  
  func datetimeWithDate(_ date:Date , time:Date) -> Date? {
    
    let currentCalendar = Calendar.current
    let dateComponents = (currentCalendar as NSCalendar).components([.day, .month, .year], from: date)
    let hourComponents = (currentCalendar as NSCalendar).components([.hour, .minute], from: time)
    
    let dateWithTime = (currentCalendar as NSCalendar).date(byAdding: hourComponents, to:currentCalendar.date(from: dateComponents)!, options:NSCalendar.Options(rawValue: 0))
    
    return dateWithTime;
    
  }
  
  
  var startDate:Date? {
    get {
      
      return datetimeWithDate(dateCell.date as Date, time: startTimeCell.date as Date )
    }
  }
  
  var endDate:Date? {
    get {
      let endDate = startDate?.addingTimeInterval(durationInMinutes*kSecondsInMinute)
      return endDate
    }
  }
  
  var distance:Double {
    get {
      return distanceCell.doubleValue
    }
  }
  
  
  var durationInMinutes:Double {
    get {
      return durationTimeCell.doubleValue
    }
  }
  
  var energyBurned:Double? {
    return caloriesCell.doubleValue
    
  }
  
  func updateOKButtonStatus() {
    
    self.navigationItem.rightBarButtonItem?.isEnabled = ( distanceCell.doubleValue > 0 && caloriesCell.doubleValue > 0 && distanceCell.doubleValue > 0);
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    dateCell.inputMode = .date
    startTimeCell.inputMode = .time
    
    
    
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    
    let endDate = Date()
    let startDate = endDate.addingTimeInterval(-kDefaultWorkoutDuration)
    
    dateCell.date = startDate;
    startTimeCell.date = startDate
    
    let formatter = LengthFormatter()
    formatter.unitStyle = .long
    let unit = distanceUnit == DistanceUnit.kilometers ? LengthFormatter.Unit.kilometer : LengthFormatter.Unit.mile
    let unitString = formatter.unitString(fromValue: 2.0, unit: unit)
    distanceCell.textLabel?.text = "Distance (" + unitString.capitalized + ")"
    
    self.navigationItem.rightBarButtonItem?.isEnabled  = false
    
    
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
  }
  
  override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    
    tableView.deselectRow(at: indexPath, animated: true)
  }
  
  
  @IBAction func textFieldValueChanged(_ sender:AnyObject ) {
    updateOKButtonStatus()
  }
  
  
  
}

