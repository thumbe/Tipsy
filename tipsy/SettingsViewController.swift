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
    static let DEFAULT_VALUE_KEY = "default_value_key";
     static let WOW_THEME_SELECTED_KEY = "theme_selected_key";
    @IBOutlet weak var themeSwitcher: UISwitch!
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        let defaults = NSUserDefaults.standardUserDefaults()
        let intValue = defaults.integerForKey(SettingsViewController.DEFAULT_VALUE_KEY);
        
        defaultTipSelector.selectedSegmentIndex = intValue;
        
        themeSwitcher.on = defaults.boolForKey(SettingsViewController.WOW_THEME_SELECTED_KEY)
        
    }
    
    @IBAction func onValueChange(sender: AnyObject) {
        let defaults = NSUserDefaults.standardUserDefaults()
        defaults.setInteger(defaultTipSelector.selectedSegmentIndex, forKey: SettingsViewController.DEFAULT_VALUE_KEY)
        defaults.synchronize()
    }
    
    @IBAction func onThemeChanged(sender: AnyObject) {
        let defaults = NSUserDefaults.standardUserDefaults()
        
        defaults.setBool(themeSwitcher.on, forKey: SettingsViewController.WOW_THEME_SELECTED_KEY)
        defaults.synchronize()
        
    }
}
