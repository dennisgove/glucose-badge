//
//  AppDelegate.swift
//  glucose-badge
//
//  Created by Dennis Gove on 12/5/15.
//  Copyright © 2015 gove. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, ReceiverNotificationDelegate {

    var window: UIWindow?
    var app: UIApplication!
    var receiver: Receiver?

    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        self.app = application
        self.receiver = createReceiver()
        self.receiver?.readingNotifier = self
        self.receiver?.connect()

        self.resignFirstResponder()

        // Ask user for notification because we're gonna write to the badge
        application.registerUserNotificationSettings(UIUserNotificationSettings(forTypes: UIUserNotificationType.Badge, categories: nil))

        // Clear any previous value there
        // This is done in the viewDidLoad method of the ViewController

        return true
    }

    private func createReceiver() -> Receiver? {

//        return StaticValuesReceiver(
//            readings: [Reading(value:70, timestamp:NSDate()), Reading(value:80, timestamp:NSDate())],
//            valueChangeInterval: 2.5
//        )

        return xDripG5Receiver(transmitterId: NSUserDefaults.standardUserDefaults().transmitterId)
    }

    private func updateGlucose(reading: Reading){
        app.applicationIconBadgeNumber = Int(reading.value)

        let vc = self.window!.rootViewController as! ViewController
        vc.setMostRecent(reading)
    }

    func receiver(receiver: Receiver, didReceiveReading: Reading) {
        updateGlucose(didReceiveReading)
//        app.applicationIconBadgeNumber = Int(didReceiveReading.value)
    }

    func receiver(receiver: Receiver, didExperienceError: ErrorType) {
        updateGlucose(Reading(value:11, timestamp: NSDate()))
//        app.applicationIconBadgeNumber = 11
    }

    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

