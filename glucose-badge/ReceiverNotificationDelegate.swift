//
//  ReceiverNotificationDelegate.swift
//  glucose-badge
//
//  Created by Dennis Gove on 1/18/16.
//  Copyright © 2016 gove. All rights reserved.
//

import Foundation

protocol ReceiverNotificationDelegate: class {
    func receiver(receiver: Receiver, didReceiveReading: Reading)

    // TODO: decide if we need a designated error callback. Perhaps Reading can
    // become a protocol that can have GlucoseReading and ErrorReading
//    func receiver(receiver: Receiver, didReceiverError: ReceiverError)

//    func communicationLost(receiver: Receiver)

//    func communicationGained(receiver: Receiver)
}