//
//  ViewController.swift
//  tipsy
//
//  Created by Tushar Humbe on 8/28/16.
//  Copyright © 2016 Tushar Humbe. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var tipLabel: UILabel!
    @IBOutlet weak var billLabel: UITextField!
    @IBOutlet weak var amountLabel: UILabel!
    @IBOutlet weak var tipTextBox: UITextField!
    @IBOutlet weak var tipSelector: UISegmentedControl!
    
    var existingTip: Double = 0;
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        //tipSelector.setTitle("20%", forSegmentAtIndex: 0);
        //tipSelector.setTitle("30%", forSegmentAtIndex: 1);
        //tipSelector.setTitle("40%", forSegmentAtIndex: 2);
        
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        let defaults = NSUserDefaults.standardUserDefaults()
        let intValue = defaults.integerForKey(SettingsViewController.DEFAULT_VALUE_KEY);
        
        tipSelector.selectedSegmentIndex = intValue;
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    @IBAction func dismissKeyboard(sender: AnyObject) {
        view.endEditing(true)
    }
    
    
    @IBAction func onAmountChanged(sender: AnyObject) {
        if (tipSelector.selectedSegmentIndex >= 0) {
            if (tipSelector.selectedSegmentIndex == 3) {
                
                tipTextBox.hidden = false
                tipLabel.hidden = true
                tipTextBox.text = String.init(format: "%.2f", existingTip);
                tipTextBox.becomeFirstResponder()
                return
            } else {
                tipTextBox.hidden = true
                tipLabel.hidden = false
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
    @IBAction func onTipEntered(sender: AnyObject) {
        
        let bill = Double(billLabel.text!) ?? 0
        
        let tip = Double(tipTextBox.text!) ?? 0
        
        let total = tip + bill
        tipLabel.text = String.init(format: "$%.2f", tip)
        amountLabel.text = String.init(format: "$%.2f", total)
        
    }
    
    
}

