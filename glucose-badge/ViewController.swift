//
//  ViewController.swift
//  glucose-badge
//
//  Created by Dennis Gove on 12/5/15.
//  Copyright © 2015 gove. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var transmitterIdField: UITextField!
    @IBOutlet weak var showOnBadgeSwitch: UISwitch!
    @IBOutlet weak var showOnLockScreenSwitch: UISwitch!
    @IBOutlet weak var mostRecentValue: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.

        mostRecentValue.text = "???"
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func displayMostRecentValue(value: Int){
        mostRecentValue.text = String(value)
    }

}

