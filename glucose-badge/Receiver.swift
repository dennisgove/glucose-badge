//
//  Receiver.swift
//  glucose-badge
//
//  Created by Dennis Gove on 1/18/16.
//  Copyright © 2016 gove. All rights reserved.
//

import Foundation

protocol Receiver : class {

    // Open conection with the underlying transmitter.
    // If already open then considered a no-op
    func connect() -> Bool

    // Close connectino with the underlying transmitter
    // If already closed then considered a no-op
    func disconnect() -> Bool

    var readingNotifier: ReceiverNotificationDelegate? {
        get
        set
    }
}