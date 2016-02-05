//
//  xDripG5Receiver.swift
//  glucose-badge
//
//  Created by Dennis Gove on 1/21/16.
//  Copyright © 2016 gove. All rights reserved.
//

import Foundation
import CoreBluetooth
import xDripG5

class xDripG5Receiver: NSObject, Receiver, TransmitterDelegate {

    private var transmitter: Transmitter!
    private var notifier: ReceiverNotificationDelegate?
    private var latestReading: Reading?
    private var disconnectTimer: NSTimer?
    private final var xDripG5Timeout = (Double)(60 * 6) // we will allow 6 minutes before calling a disconnect

    internal init(transmitterId: String) {
        super.init()
        
        transmitter = Transmitter(
            ID: transmitterId,
            startTimeInterval: nil,
            passiveModeEnabled: true
        )
        transmitter?.stayConnected = true
        transmitter?.delegate = self

    }

    var readingNotifier: ReceiverNotificationDelegate? {
        get{ return self.notifier }
        set{ self.notifier = newValue }
    }

    func connect() -> Bool {
        transmitter.resumeScanning()
        self.resetDisconnectTimer()
        sendReceiverEvent(ReceiverEventCode.CONNECTED_WAITING_FOR_FIRST_READING, withLatestReading: latestReading)
        return true
    }

    func disconnect() -> Bool {
        self.cancelDisconnectTimer()
        transmitter.stopScanning()
        sendReceiverEvent(ReceiverEventCode.DISCONNECTED, withLatestReading: latestReading)
        return true
    }


    private func cancelDisconnectTimer(){
        if(nil != disconnectTimer){
            disconnectTimer?.invalidate()
            disconnectTimer = nil
        }
    }

    private func resetDisconnectTimer(){
        self.cancelDisconnectTimer()
        disconnectTimer = NSTimer.scheduledTimerWithTimeInterval(xDripG5Timeout, target: self, selector: "handleDisconnect", userInfo: nil, repeats: false)
    }

    func handleDisconnect(){
        sendReceiverEvent(ReceiverEventCode.LOST_CONNECTION, withLatestReading: latestReading)
    }

    func transmitter(transmitter: Transmitter, didReadGlucose glucose: GlucoseRxMessage){
        let reading = Reading(value:glucose.glucose, timestamp:NSDate())
        latestReading = reading
        self.resetDisconnectTimer()
        self.sendReceiverEvent(ReceiverEventCode.CONNECTED_LAST_READING_GOOD, withLatestReading: latestReading)
    }

    func transmitter(transmitter: Transmitter, didError error: ErrorType){
        self.resetDisconnectTimer()
        self.sendReceiverEvent(ReceiverEventCode.CONNECTED_LAST_READING_ERROR, withLatestReading: latestReading)
    }

    func sendReceiverEvent(eventCode: ReceiverEventCode, withLatestReading: Reading?){
        if(nil != notifier){
            notifier!.receiver(self, hadEvent: eventCode, withLatestReading: withLatestReading)
        }
    }
}