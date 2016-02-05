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
    private var latestReading: Reading?

    internal init(readings: [Reading]?, valueChangeInterval: Double) {
        self.readings = readings
        self.valueChangeInterval = valueChangeInterval
        self.nextValueIdx = 0
    }


    func sendNextValue() {
        if(nil != notifier && nil != readings){
            var reading = readings![nextValueIdx]
            reading.timestamp = NSDate()
            latestReading = reading
            sendReceiverEvent(ReceiverEventCode.CONNECTED_LAST_READING_GOOD, withLatestReading: latestReading)
            nextValueIdx = (nextValueIdx + 1) % readings!.count
        }
    }

    // Begin sending values through the notifier
    // Returns false if no values exist to send or notifier is null
    func connect() -> Bool {
        if(nil == self.notifier || nil == self.readings || 0 == self.readings?.count){
            sendReceiverEvent(ReceiverEventCode.DISCONNECTED, withLatestReading: latestReading)
            return false
        }

        if(nil == valueSender){
            valueSender = NSTimer.scheduledTimerWithTimeInterval(valueChangeInterval, target: self, selector: "sendNextValue", userInfo: nil, repeats: true)
            sendReceiverEvent(ReceiverEventCode.CONNECTED_WAITING_FOR_FIRST_READING, withLatestReading: latestReading)
        }
        return true
    }

    // Stop sending values through the notifier
    // Always returns true
    func disconnect() -> Bool {
        if(nil != valueSender){
            valueSender?.invalidate()
            valueSender = nil
            sendReceiverEvent(ReceiverEventCode.DISCONNECTED, withLatestReading: latestReading)
        }
        return true
    }

    func sendReceiverEvent(eventCode: ReceiverEventCode, withLatestReading: Reading?){
        if(nil != notifier){
            notifier!.receiver(self, hadEvent: eventCode, withLatestReading: withLatestReading)
        }
    }

    var readingNotifier: ReceiverNotificationDelegate? {
        get{ return self.notifier }
        set{ self.notifier = newValue }
    }

}