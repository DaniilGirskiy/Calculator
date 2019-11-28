//
//  CalculatorModel.swift
//  Calculator(Stack)
//
//  Created by Danya on 16/11/2019.
//  Copyright © 2019 Daniil Girskiy. All rights reserved.
//

import Foundation

protocol CalculatorModelOutput {
    func display(string: String)
}

enum Operation {
    case digit(Double)
    case sign(MathOperation)
    case result
    case clean
    case dot
}

enum InternalState {
    case initial
    case input(Double)
    case mathOperation(MathOperation)
    case result
    case clean
    case dot
}

//MARK: - хуй
enum MathOperation: String {
    case plus = "+"
    case minus = "-"
    case multiply = "×"
    case divide = "÷"
}

// деревья (посмотреть инфу)


private extension CalculatorModelImpl {
    func newInternalState(_ inputState: Operation) -> InternalState {
        switch inputState {
        case .digit(let digit):
            return .input(digit)
        case .sign(let sign):
            return .mathOperation(sign)
        case .result:
            return .result
        case .clean:
            return .clean
        case .dot:
            return .dot
        }
    }
}

private extension CalculatorModelImpl {
    func processWith(state: InternalState) {
        switch state {
        case .input(let digit):                                   // INPUT VALUE
            switch prevState {
            case .initial, .clean, .mathOperation(_), .result:
                
                currentValue = digit
                correctOutput(double: currentValue)
                
            case .input(_):  // добавить условие на ввод до 9 цифр максимум
                
                currentValue = currentValue * 10 + digit
                correctOutput(double: currentValue)
                
            case .dot:
                
                currentValue = 0.1 * (currentValue * 10 + digit)  // с точкой ебала пока (а было норм!!!!)
                correctOutput(double: currentValue)
                
            }
                
                
        case .mathOperation(let sign):  // сначала ..., потом знак
            switch prevState {
            case .initial, .clean:
                
                digitsStack.push(currentValue)
                signsStack.push(sign)
                
            case .input, .dot:
                
                digitsStack.push(currentValue)
                
                copyDigitsStack = digitsStack  // сохраняем копии стеков на случай отката
                copySignsStack = signsStack
                
                while !signsStack.isEmpty() && digitsStack.count() >= 2 {
                    if priority(sign: signsStack.peek().rawValue) >= priority(sign: sign.rawValue) {
                        doOperation(secondOperand: digitsStack.pop(),
                                    firstOperand: digitsStack.pop(),
                                    sign: signsStack.pop())
                    } else {
                        break
                    }
                }
                
                signsStack.push(sign)
                
                currentValue = digitsStack.peek()                       // ????????
                correctOutput(double: currentValue)
                
            case .mathOperation: // меняем знак
                
                if copySignsStack.count() >= 1 && copyDigitsStack.count() >= 2 {
                    digitsStack = copyDigitsStack
                    signsStack = copySignsStack
                } else {
                    //signsStack.pop()
                    signsStack.clean()
                }
                
                // повтор, см. выше DRY!
                
                copyDigitsStack = digitsStack  // сохраняем копии стеков на случай отката
                copySignsStack = signsStack
                
                while !signsStack.isEmpty() && digitsStack.count() >= 2 {
                    if priority(sign: signsStack.peek().rawValue) >= priority(sign: sign.rawValue) {
                        doOperation(secondOperand: digitsStack.pop(),
                                    firstOperand: digitsStack.pop(),
                                    sign: signsStack.pop())
                    } else {
                        break
                    }
                }
                
                signsStack.push(sign)
                
                currentValue = digitsStack.peek()                       // ????????
                correctOutput(double: currentValue)
                
            case .result:
                
                signsStack.push(sign)
                
                copySignsStack.clean()
                copyDigitsStack.clean()
                
            
            }
            
            
            
        case .result:
            switch prevState {
            case .initial, .clean:
                break
            case .input, .dot:     // 7 * 5 = ->35; 3 = ->15
                
//                if digitsStack.count() == 1 && signsStack.isEmpty() &&
//                    !copyDigitsStack.isEmpty() && !copySignsStack.isEmpty() {
//                    digitsStack.clean()
//                }
                
                digitsStack.push(currentValue)
                
//                if !copyDigitsStack.isEmpty() && !copySignsStack.isEmpty() {
//                    signsStack.push(copySignsStack.peek())
//                    digitsStack.push(copyDigitsStack.peek())
//                }
                
                copyDigitsStack = digitsStack  // сохраняем копии стеков на случай отката
                copySignsStack = signsStack
                
                while !signsStack.isEmpty() && digitsStack.count() >= 2 {
                    doOperation(secondOperand: digitsStack.pop(),
                                firstOperand: digitsStack.pop(),
                                sign: signsStack.pop())
                }
                
                currentValue = digitsStack.peek()                       // ????????
                correctOutput(double: currentValue)
                
            case .mathOperation:   // 5+= ->10  5+5*= ->30
                
                digitsStack.push(digitsStack.peek())
                
                copyDigitsStack = digitsStack  // сохраняем копии стеков на случай отката
                copySignsStack = signsStack
                
                while !signsStack.isEmpty() && digitsStack.count() >= 2 {
                    doOperation(secondOperand: digitsStack.pop(),
                                firstOperand: digitsStack.pop(),
                                sign: signsStack.pop())
                }
                
                currentValue = digitsStack.peek()                       // ????????
                correctOutput(double: currentValue)
                
            case .result:  // 5+5= ->10; = ->15; = ->20
                
                if !copyDigitsStack.isEmpty() && !copySignsStack.isEmpty() {
                    signsStack.push(copySignsStack.peek())
                    digitsStack.push(copyDigitsStack.peek())
                }
                
                copyDigitsStack = digitsStack  // сохраняем копии стеков на случай отката
                copySignsStack = signsStack
                
                while !signsStack.isEmpty() && digitsStack.count() >= 2 {
                    doOperation(secondOperand: digitsStack.pop(),
                                firstOperand: digitsStack.pop(),
                                sign: signsStack.pop())
                }
                
                currentValue = digitsStack.peek()                       // ????????
                correctOutput(double: currentValue)
                
            }
            
            
        case .clean:
            digitsStack.clean()
            signsStack.clean()
            copyDigitsStack.clean()
            copySignsStack.clean()
            currentInputOnDisplay = "0"
            currentValue = 0
            
            //prevState = .initial
            
            output?.display(string: currentInputOnDisplay)
            
        case .dot:
            switch prevState {
            case .initial, .clean:
                
                currentInputOnDisplay += "."
                output?.display(string: currentInputOnDisplay)
                
            case .input:
                
                if !currentInputOnDisplay.contains(".") {
                    currentInputOnDisplay += "."
                    output?.display(string: currentInputOnDisplay)
                }
                
            case .mathOperation:
                
                currentInputOnDisplay = "0."
                output?.display(string: currentInputOnDisplay)
                
            case .result:
                
                currentInputOnDisplay = "0."
                output?.display(string: currentInputOnDisplay)
                
            case .dot:
                break
            }
            
        default:
            break
        }
        
        prevState = state
       
    }
}















class CalculatorModelImpl: CalculatorModel {
    
    var currentInputOnDisplay = "0"
    var currentValue = 0.0
    
    var digitsStack = Stack<Double>()
    var signsStack = Stack<MathOperation>()
    var copyDigitsStack = Stack<Double>()
    var copySignsStack = Stack<MathOperation>()
    
    private var prevState: InternalState = .initial
    
    var output: CalculatorModelOutput? // почему optional?
    
    private func doOperation(secondOperand: Double, firstOperand: Double, sign: MathOperation) {
        switch sign.rawValue {
        case "+":
            digitsStack.push(firstOperand + secondOperand)
        case "-":
            digitsStack.push(firstOperand - secondOperand)
        case "×":
            digitsStack.push(firstOperand * secondOperand)
        case "÷":
            digitsStack.push(firstOperand / secondOperand)
        default:
            break
        }
    }
    
    
    private func correctOutput(double: Double) {           //correct?   + округление до 9 цифр на дисплее
        let result = double - floor(double)
        if result == 0 {
            currentInputOnDisplay = String(Int(double))
        } else {
            currentInputOnDisplay = String(double)
        }
        output?.display(string: currentInputOnDisplay)
    }
    
    
    func input(op: Operation) {
        
       let internalState = newInternalState(op)
        processWith(state: internalState)
        
    }
}
