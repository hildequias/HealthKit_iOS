//
//  FirstResponderlCell.swift
//  HKTutorialPrototype
//
//  Created by ernesto on 18/10/14.
//  Copyright (c) 2014 cocoawithchurros. All rights reserved.
//

import UIKit

open class DatePickerCell: UITableViewCell {

    
    
    public enum DateCellInputMode
    {
        case date, time
        
    }
    
    open var inputMode:DateCellInputMode = .date  {
        
        didSet {
            switch inputMode {
            case .date:
                datePicker.datePickerMode = .date
            case .time:
                datePicker.datePickerMode = .time
                break
            }
        }
    }
    
    
    var date:Date {
        
        get { return datePicker.date }
        
        set (newDate) {
            datePicker.date = newDate
            updateDateTimeLabel()
        }
        
    }
        
    lazy var dateFormatter:DateFormatter = {
        
        let formatter = DateFormatter()
        formatter.timeStyle = .none
        formatter.dateStyle = .medium
        return formatter;
        
    }()

    lazy var timeFormatter:DateFormatter = {
        
        let formatter = DateFormatter()
        formatter.timeStyle = .short
        formatter.dateStyle = .none
        return formatter;
        }()
    
    lazy var datePicker:UIDatePicker = {
        
        let picker = UIDatePicker()
        picker.addTarget(self, action: #selector(DatePickerCell.datePickerValueChanged), for: UIControlEvents.valueChanged)
        return picker
    }()
    
    func updateDateTimeLabel() {
        
        var dateText = ""
        let date = datePicker.date
        switch inputMode {
        case .date:
            dateText = dateFormatter.string(from: date)
        case .time:
            dateText = timeFormatter.string(from: date)
            break
        }
        self.detailTextLabel?.text = dateText;

    }
    
    func datePickerValueChanged( ) {
        
        updateDateTimeLabel()
    }

    
    open override var canBecomeFirstResponder : Bool {
        return true;
    }
    
    open override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        if( selected ) {
            self.becomeFirstResponder()
        }
        
    }
    open override var inputView: UIView! {
        get {
            return datePicker
        }
    }
    
    
    
    
    
}
