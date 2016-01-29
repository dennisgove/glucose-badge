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
            return stringForKey("transmitterId") ?? "??????"
        }
        set {
            setObject(newValue, forKey: "transmitterId")
        }
    }
}
