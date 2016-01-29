//
//  StaticValuesReceiver.swift
//  glucose-badge
//
//  Created by Dennis Gove on 1/18/16.
//  Copyright © 2016 gove. All rights reserved.
//

import Foundation

// Implements a receiver which will iterate through a list of static
// values at some fixed rate. This can be used for testing purposes.

class StaticValuesReceiver : NSObject, Receiver {

    private var notifier: ReceiverNotificationDelegate?
    private var readings: [Reading]?
    private var valueChangeInterval: Double
    private var valueSender: NSTimer?
    private var nextValueIdx: Int

    internal init(readings: [Reading]?, valueChangeInterval: Double) {
        self.readings = readings
        self.valueChangeInterval = valueChangeInterval
        self.nextValueIdx = 0
    }


    func sendNextValue() {
        if(nil != notifier && nil != readings){
            var reading = readings![nextValueIdx]
            reading.timestamp = NSDate()
            notifier?.receiver(self, didReceiveReading: reading)
            nextValueIdx = (nextValueIdx + 1) % readings!.count
        }
    }

    // Begin sending values through the notifier
    // Returns false if no values exist to send or notifier is null
    func connect() -> Bool {
        if(nil == self.notifier || nil == self.readings || 0 == self.readings?.count){
            sendCodedNotification(ReceiverCode.DISCONNECTED)
            return false
        }

        if(nil == valueSender){
            valueSender = NSTimer.scheduledTimerWithTimeInterval(valueChangeInterval, target: self, selector: "sendNextValue", userInfo: nil, repeats: true)
            sendCodedNotification(ReceiverCode.CONNECTED_WAITING_FOR_FIRST_READING)
        }
        return true
    }

    // Stop sending values through the notifier
    // Always returns true
    func disconnect() -> Bool {
        if(nil != valueSender){
            valueSender?.invalidate()
            valueSender = nil
            sendCodedNotification(ReceiverCode.DISCONNECTED)
        }
        return true
    }

    func sendCodedNotification(code: ReceiverCode){
        if(nil != notifier){
            let reading = Reading(value:code.rawValue, timestamp:NSDate())
            notifier!.receiver(self, didReceiveReading: reading)
        }
    }

    var readingNotifier: ReceiverNotificationDelegate? {
        get{ return self.notifier }
        set{ self.notifier = newValue }
    }

}