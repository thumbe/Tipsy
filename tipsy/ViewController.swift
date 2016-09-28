//
//  ViewController.swift
//  tipsy
//
//  Created by Tushar Humbe on 8/28/16.
//  Copyright © 2016 Tushar Humbe. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    static let PREVIOUS_BILL_AMOUNT_KEY = "PREVIOUS_BILL_AMOUNT"
    static let PREVIOUS_BILL_AMOUNT_TIME_KEY = "PREVIOUS_BILL_AMOUNT_TIME"
    // time in milliseconds for which the bill amount is saved between app restarts
    let billPersistentTimeMS: Double = 10*1000;
    @IBOutlet weak var tipLabel: UILabel!
    
    // TODO: refractor to someting billTextField. Why cannot we refactor in swift?! :o
    @IBOutlet weak var billLabel: UITextField!
    @IBOutlet weak var amountLabel: UILabel!
    @IBOutlet weak var tipTextBox: UITextField!
    @IBOutlet weak var tipSelector: UISegmentedControl!
    
    var existingTip: Double = 0;
    var imageView: UIImageView = UIImageView(frame: CGRect(x: 0, y: 20, width: 320, height: 320));
    
    override func viewDidLoad() {
        super.viewDidLoad()
        billLabel.becomeFirstResponder()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        
        let defaults = UserDefaults.standard
        
        imageView.image = UIImage(named: "manutdLogo.png")
        self.view.insertSubview(imageView, at: 0)
        
        if (defaults.bool(forKey: SettingsViewController.WOW_THEME_SELECTED_KEY)) {
            self.view.backgroundColor = UIColor.red.withAlphaComponent(0.9);
            
            imageView.clipsToBounds = true
            imageView.contentMode = UIViewContentMode.scaleAspectFit
        } else {
            self.view.backgroundColor = UIColor.white;
            imageView.removeFromSuperview()
        }
        
        // set any previous bill amount if we have any within certain time.
        if ((NSDate().timeIntervalSince1970 * 1000) - defaults.double(forKey: ViewController.PREVIOUS_BILL_AMOUNT_TIME_KEY) < billPersistentTimeMS) {
            billLabel.text = defaults.string(forKey: ViewController.PREVIOUS_BILL_AMOUNT_KEY)
        } else {
            billLabel.text = ""
        }
        
        let intValue = defaults.integer(forKey: SettingsViewController.DEFAULT_VALUE_KEY);
        
        tipSelector.selectedSegmentIndex = intValue;
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        // save current bill amount and time in miliseconds
        UserDefaults.standard.set(billLabel.text, forKey: ViewController.PREVIOUS_BILL_AMOUNT_KEY)
        print("viewWillDisappear: "+String(NSDate().timeIntervalSince1970))
        UserDefaults.standard.set(NSDate().timeIntervalSince1970 * 1000, forKey: ViewController.PREVIOUS_BILL_AMOUNT_TIME_KEY)
        UserDefaults.standard.synchronize()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    @IBAction func dismissKeyboard(_ sender: AnyObject) {
        view.endEditing(true)
    }
    
    
    @IBAction func onAmountChanged(_ sender: AnyObject) {
        if (tipSelector.selectedSegmentIndex >= 0) {
            if (tipSelector.selectedSegmentIndex == 3) {
                
                tipTextBox.isHidden = false
                tipLabel.isHidden = true
                tipTextBox.text = String.init(format: "%.2f", existingTip);
                tipTextBox.becomeFirstResponder()
                return
            } else {
                tipTextBox.isHidden = true
                tipLabel.isHidden = false
                billLabel.becomeFirstResponder()
                
            }
        let tipValues = [0.15, 0.18, 0.20, 0.25]
        
        let bill = Double(billLabel.text!) ?? 0
        let tip = bill * tipValues[tipSelector.selectedSegmentIndex];
            existingTip = tip;
        let total = bill + tip;
        
        tipLabel.text = String.init(format: "$%.2f", tip)
        amountLabel.text = String.init(format: "$%.2f", total)
            
        }
        
    }
    @IBAction func onTipEntered(_ sender: AnyObject) {
        
        let bill = Double(billLabel.text!) ?? 0
        
        let tip = Double(tipTextBox.text!) ?? 0
        
        let total = tip + bill
        tipLabel.text = String.init(format: "$%.2f", tip)
        amountLabel.text = String.init(format: "$%.2f", total)
        
    }
    
    
}

