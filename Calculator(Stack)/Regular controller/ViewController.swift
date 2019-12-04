//
//  ViewController.swift
//  Calculator(Stack)
//
//  Created by Danya on 08/11/2019.
//  Copyright © 2019 Daniil Girskiy. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var displayLabel: UILabel!

    var model: CalculatorModel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        model.output = self
    }

    @IBAction func digitPressed(_ sender: UIButton) {
        let tag = sender.tag   // tags
        
        if tag > 0 && tag < 10 {
            model.input(op: .digit(Double(tag)))
        } else if tag == 10 {
            model.input(op: .digit(0))
        }
        
    }
    
    @IBAction func signPressed(_ sender: UIButton) {
        let tag = sender.tag
        
        if tag == 11 {
            model.input(op: .sign(.plus))
        } else if tag == 12 {
            model.input(op: .sign(.minus))
        } else if tag == 13 {
            model.input(op: .sign(.multiply))
        } else if tag == 14 {
            model.input(op: .sign(.divide))
        }
    
    }

    @IBAction func resultButtonPressed(_ sender: UIButton) {
        model.input(op: .result)
    }
    
    @IBAction func clearButtonPressed(_ sender: UIButton) {
        model.input(op: .clean)
    }
    
    @IBAction func dotButtonPressed(_ sender: UIButton) {
        model.input(op: .dot)
    }
    
}

extension ViewController: CalculatorModelOutput {
    func display(string: String) {
        displayLabel.text = string
    }
}
