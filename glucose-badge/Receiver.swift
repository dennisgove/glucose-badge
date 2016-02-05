//
//  Receiver.swift
//  glucose-badge
//
//  Created by Dennis Gove on 1/18/16.
//  Copyright © 2016 gove. All rights reserved.
//

import Foundation

public enum ReceiverEventCode: UInt16 {
    case CONNECTED_WAITING_FOR_FIRST_READING = 1
    case CONNECTED_LAST_READING_ERROR = 2
    case CONNECTED_LAST_READING_GOOD = 3
    case DISCONNECTED = 4
    case LOST_CONNECTION = 5
}

protocol Receiver : class {

    // Open conection with the underlying transmitter.
    // If already open then considered a no-op
    func connect() -> Bool

    // Close connectino with the underlying transmitter
    // If already closed then considered a no-op
    func disconnect() -> Bool

    // Max # of seconds to wait for a reading. If haven't gotten a new reading
    // within this timeframe then notify the client
//    var maxReadingWait: Int {
//        get
//        set
//    }

    var readingNotifier: ReceiverNotificationDelegate? {
        get
        set
    }
}