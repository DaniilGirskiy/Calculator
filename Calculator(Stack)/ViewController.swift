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

    private let model = CalculatorModelImpl()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        model.output = self
    }

    @IBAction func digitPressed(_ sender: UIButton) {
        let digit = sender.currentTitle!
        
        model.input(op: .digit(digit))
        
    }
    
    @IBAction func signPressed(_ sender: UIButton) {
        let sign = sender.currentTitle!
        
        model.input(op: .sign(sign))
    
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
