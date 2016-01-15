//
//  StaticTestTransmitter.swift
//  glucose-badge
//
//  Created by Dennis Gove on 1/14/16.
//  Copyright © 2016 gove. All rights reserved.
//

import Foundation
import xDripG5

public class StaticTestTransmitter: NSObject, Transmitter {

    public var transmitterId: String

    private var transmitterDelegate: TransmitterDelegate?
    private var valueChangeInterval: Double
    private var staticValues: [UInt16]
    private var nextValueIdx: Int
//    private var timer: NSTimer?

    public init(transmitterId: String, valueChangeInterval: Double, staticValues: [UInt16]) {
        self.transmitterId = transmitterId
        self.valueChangeInterval = valueChangeInterval
        self.staticValues = staticValues
        self.nextValueIdx = 0
        print("foo")
    }

    func sendNextValue() {

        let glucoseMessage = TestGlucoseRxMessage(glucoseValue: staticValues[nextValueIdx])
        nextValueIdx = (nextValueIdx + 1) % staticValues.count

        self.delegate?.transmitter(self, didReadGlucose: glucoseMessage!)
    }

    public var delegate: TransmitterDelegate? {
        get{
            return transmitterDelegate
        }
        set{
            NSTimer.scheduledTimerWithTimeInterval(valueChangeInterval, target: self, selector: "sendNextValue", userInfo: nil, repeats: true)
            transmitterDelegate = newValue
//            sendNextValue()
        }
    }

    public func resumeScanning() {

    }

    public func stopScanning() {
    }

    public var isScanning: Bool {
        return true
    }

    public var stayConnected: Bool {
        get {
            return true
        }
        set {
            // ain't doing anything
        }
    }
}

public struct TestGlucoseRxMessage: GlucoseRxMessage {
    var glucoseValue: UInt16

    public var glucose: UInt16{
        get{ return self.glucoseValue }
        set{ self.glucoseValue = newValue }
    }

    public init?(data: NSData) {
        glucoseValue = 0
    }

    public init?(glucoseValue: UInt16) {
        self.glucoseValue = glucoseValue
    }
}

