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

        note.numberOfLines = 10
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    internal func handleReceiverEvent(eventCode: ReceiverEventCode, withLatestReading: Reading?){
        let mydateFormatter = NSDateFormatter()
        mydateFormatter.calendar = NSCalendar(calendarIdentifier: "NSCalendarIdentifierISO8601")
        mydateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss xx"
        mydateFormatter.locale = NSLocale(localeIdentifier: "en_US_POSIX")

        switch(eventCode){
        case ReceiverEventCode.CONNECTED_LAST_READING_GOOD:
            note.text = "We're all good (I think)"
            note.textColor = UIColor.blueColor()
            mostRecentValue.text = String(withLatestReading!.value)
            atTime.text = mydateFormatter.stringFromDate(withLatestReading!.timestamp)
            break

        case ReceiverEventCode.CONNECTED_WAITING_FOR_FIRST_READING:
            note.text = "Connected and waiting for first reading"
            note.textColor = UIColor.magentaColor()
            mostRecentValue.text = "Waiting..."
            atTime.text = mydateFormatter.stringFromDate(NSDate())
            break

        case ReceiverEventCode.CONNECTED_LAST_READING_ERROR:
            note.text = "Last reading was an error\n"
            note.textColor = UIColor.redColor()
            mostRecentValue.text = "!Receiver Error!..."
            atTime.text = mydateFormatter.stringFromDate(NSDate())
            break

        case ReceiverEventCode.DISCONNECTED:
            note.text = "We are disconnected"
            note.textColor = UIColor.brownColor()
            mostRecentValue.text = "Disconnected..."
            atTime.text = mydateFormatter.stringFromDate(NSDate())

        case ReceiverEventCode.LOST_CONNECTION:
            note.text = "Connection Lost..."
            note.textColor = UIColor.redColor()
            mostRecentValue.text = "Lost..."
            atTime.text = mydateFormatter.stringFromDate(NSDate())
        }

        if(nil != withLatestReading){
            note.text! += "\nThe last received reading was " + String(withLatestReading!.value) + " at " + mydateFormatter.stringFromDate(withLatestReading!.timestamp)
        }
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

