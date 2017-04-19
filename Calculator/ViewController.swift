//
//  ViewController.swift
//  Calculator
//
//  Created by Andriy Krupych on 4/18/17.
//  Copyright © 2017 Andriy Krupych. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var display: UILabel!
    
    private var brain = CalculatorBrain()
    
    var displayNumber: Double {
        get { return Double(display.text!)! }
        set { display.text = String(newValue) }
    }
    
    override func viewDidLoad() {
        displayNumber = brain.result
    }
    
    @IBAction func touchDigit(_ sender: UIButton) {
        let digit = sender.currentTitle!
        if (digit == "π") {
            displayNumber = Double.pi
        } else if (displayNumber == 0) {
            display.text = digit
        } else {
            display.text = display.text! + digit
        }
        brain.setOperand(displayNumber)
    }
    
    @IBAction func performOperation(_ sender: UIButton) {
        brain.performOperation(sender.currentTitle!)
        displayNumber = brain.result
    }

    @IBAction func clear(_ sender: UIButton) {
        brain.clear()
        displayNumber = brain.result
    }
}

