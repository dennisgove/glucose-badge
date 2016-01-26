//
//  ViewController.swift
//  glucose-badge
//
//  Created by Dennis Gove on 12/5/15.
//  Copyright © 2015 gove. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var transmitterIdField: UITextField!
    @IBOutlet weak var mostRecentValue: UILabel!
    @IBOutlet weak var atTime: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.

        transmitterIdField.text = NSUserDefaults.standardUserDefaults().transmitterId
        setMostRecent(Reading(value:10, timestamp: NSDate()))
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    internal func setMostRecent(_reading:Reading){
        mostRecentValue.text = String(_reading.value)

        let mydateFormatter = NSDateFormatter()
        mydateFormatter.calendar = NSCalendar(calendarIdentifier: "NSCalendarIdentifierISO8601")
        mydateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss xx"
        mydateFormatter.locale = NSLocale(localeIdentifier: "en_US_POSIX")
//        if let dateToBeSaved = mydateFormatter.dateFromString(myDateString) {

        atTime.text = mydateFormatter.stringFromDate(_reading.timestamp)
    }


}

