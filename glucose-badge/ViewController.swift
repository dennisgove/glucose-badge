//
//  ViewController.swift
//  glucose-badge
//
//  Created by Dennis Gove on 12/5/15.
//  Copyright © 2015 gove. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var transmitterIdField: UITextField!
    @IBOutlet weak var mostRecentValue: UILabel!
    @IBOutlet weak var atTime: UILabel!
    @IBOutlet weak var note: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.

        transmitterIdField.text = NSUserDefaults.standardUserDefaults().transmitterId
        AppDelegate.sharedDelegate.initializeReceiver(transmitterIdField.text!)

        transmitterIdField.delegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    internal func setMostRecent(_reading:Reading){
        mostRecentValue.text = String(_reading.value)

        switch(_reading.value){
        case ReceiverCode.CONNECTED_LAST_READING_ERROR.rawValue:
            note.text = "Last reading was an error"
            note.textColor = UIColor.redColor()
        case ReceiverCode.CONNECTED_WAITING_FOR_FIRST_READING.rawValue:
            note.text = "Connected and waiting for first reading"
            note.textColor = UIColor.blueColor()
        case ReceiverCode.DISCONNECTED.rawValue:
            note.text = "We are disconnected"
            note.textColor = UIColor.brownColor()
        default:
            note.text = "We're all good (I think)"
            note.textColor = UIColor.greenColor()
        }

        let mydateFormatter = NSDateFormatter()
        mydateFormatter.calendar = NSCalendar(calendarIdentifier: "NSCalendarIdentifierISO8601")
        mydateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss xx"
        mydateFormatter.locale = NSLocale(localeIdentifier: "en_US_POSIX")

        atTime.text = mydateFormatter.stringFromDate(_reading.timestamp)
    }

    func textFieldDidEndEditing(textField: UITextField) {
        AppDelegate.sharedDelegate.initializeReceiver(transmitterIdField.text!)
    }

    func textFieldShouldEndEditing(textField: UITextField) -> Bool {
        return true
    }

    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }

}

