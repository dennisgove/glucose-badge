//
//  NSUserDefaults.swift
//  glucose-badge
//
//  Created by Dennis Gove on 12/5/15.
//  Copyright © 2015 gove. All rights reserved.
//

import Foundation

extension NSUserDefaults {
    var transmitterId: String {
        get {
            return stringForKey("transmitterId") ?? "4040UD"
        }
        set {
            setObject(newValue, forKey: "transmitterId")
        }
    }

    var showOnBadge: Bool {
        get {
            return boolForKey("showOnBadgeEnabled") ?? false
        }
        set {
            setBool(newValue, forKey: "showOnBadgeEnabled")
        }
    }

    var showOnLockScreen: Bool {
        get {
            return boolForKey("showOnLockScreen") ?? false
        }
        set {
            setBool(newValue, forKey: "showOnLockScreen")
        }
    }
}
