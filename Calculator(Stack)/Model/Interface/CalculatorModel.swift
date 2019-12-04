//
//  CalculatorModel.swift
//  Calculator(Stack)
//
//  Created by Danya on 20/11/2019.
//  Copyright © 2019 Daniil Girskiy. All rights reserved.
//

import Foundation

protocol CalculatorModel: class {
    var output: CalculatorModelOutput? { get set }
    func input(op: Operation)
}
