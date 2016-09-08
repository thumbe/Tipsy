//
//  SettingsViewController.swift
//  tipsy
//
//  Created by Tushar Humbe on 9/7/16.
//  Copyright © 2016 Tushar Humbe. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {

    @IBOutlet weak var defaultTipSelector: UISegmentedControl!
    static var DEFAULT_VALUE_KEY = "default_value_key";
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
    }
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        let defaults = NSUserDefaults.standardUserDefaults()
        let intValue = defaults.integerForKey(SettingsViewController.DEFAULT_VALUE_KEY);
        
        defaultTipSelector.selectedSegmentIndex = intValue;
    }
    
    @IBAction func onValueChange(sender: AnyObject) {
        let defaults = NSUserDefaults.standardUserDefaults()
        defaults.setInteger(defaultTipSelector.selectedSegmentIndex, forKey: SettingsViewController.DEFAULT_VALUE_KEY)
        defaults.synchronize()
    }
}
