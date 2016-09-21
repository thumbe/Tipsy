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
    var imageView: UIImageView = UIImageView(frame: CGRect(x: 0, y: 20, width: 320, height: 320));
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        
        let defaults = UserDefaults.standard
        
         UIImageView(frame: CGRect(x: 0, y: 20, width: 320, height: 320))
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
        
        let intValue = defaults.integer(forKey: SettingsViewController.DEFAULT_VALUE_KEY);
        
        tipSelector.selectedSegmentIndex = intValue;
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

