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
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let defaults = UserDefaults.standard
        let intValue = defaults.integer(forKey: SettingsViewController.DEFAULT_VALUE_KEY);
        
        defaultTipSelector.selectedSegmentIndex = intValue;
        
        themeSwitcher.isOn = defaults.bool(forKey: SettingsViewController.WOW_THEME_SELECTED_KEY)
        
    }
    
    @IBAction func onValueChange(_ sender: AnyObject) {
        let defaults = UserDefaults.standard
        defaults.set(defaultTipSelector.selectedSegmentIndex, forKey: SettingsViewController.DEFAULT_VALUE_KEY)
        defaults.synchronize()
    }
    
    @IBAction func onThemeChanged(_ sender: AnyObject) {
        let defaults = UserDefaults.standard
        
        defaults.set(themeSwitcher.isOn, forKey: SettingsViewController.WOW_THEME_SELECTED_KEY)
        defaults.synchronize()
        
    }
}
