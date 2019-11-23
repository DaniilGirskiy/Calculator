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
    case digit(String)
    case sign(String)
    case clean
    case dot
}

enum InternalState {
    case initial
    case input(String)
    case mathOperation(String)
    case result
    case clean
    case dot
}

//MARK: - хуй
enum MathOperation: String {
    case plus = "+"
    //DOIT
}

// деревья (посмотреть инфу)


private extension CalculatorModelImpl {
    func newInternalState(_ inputState: Operation) -> InternalState {
        switch inputState {
        case .digit(let digit):
            return .input(digit)
        case .sign(let sign):
            return sign != "=" ? .mathOperation(sign) : .result
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
                
                currentInputOnDisplay = digit
                //output?.display(string: currentInputOnDisplay)
                correctOutput(str: currentInputOnDisplay)
                
            case .input(_):  // добавить условие на ввод до 9 цифр максимум
                
                if currentInputOnDisplay.count < 9 {
                    currentInputOnDisplay = currentInputOnDisplay == "0" ? digit : currentInputOnDisplay + digit
                    //output?.display(string: currentInputOnDisplay)
                    correctOutput(str: currentInputOnDisplay)
                }
            
            case .dot:
                
                if currentInputOnDisplay.count < 9 {
                    currentInputOnDisplay += digit
                    correctOutput(str: currentInputOnDisplay)
                }
                
            }
                
                
        case .mathOperation(let sign):  // сначала ..., потом знак
            switch prevState {
            case .initial, .clean:
                
                digitsStack.push(currentInputOnDisplay)
                signsStack.push(sign)
                
            case .input, .dot:
                
                digitsStack.push(currentInputOnDisplay)
                
                copyDigitsStack = digitsStack  // сохраняем копии стеков на случай отката
                copySignsStack = signsStack
                
                while !signsStack.isEmpty() && digitsStack.count() >= 2 {
                    if priority(sign: signsStack.peek()) >= priority(sign: sign) {
                        doOperation(secondOperand: digitsStack.pop(),
                                    firstOperand: digitsStack.pop(),
                                    sign: signsStack.pop())
                    } else {
                        break
                    }
                }
                
                signsStack.push(sign)
                
                currentInputOnDisplay = digitsStack.peek()
                //output?.display(string: currentInputOnDisplay) // вывод промежуточного результата - топовый элемент стека
                correctOutput(str: currentInputOnDisplay)
                
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
                    if priority(sign: signsStack.peek()) >= priority(sign: sign) {
                        doOperation(secondOperand: digitsStack.pop(),
                                    firstOperand: digitsStack.pop(),
                                    sign: signsStack.pop())
                    } else {
                        break
                    }
                }
                
                signsStack.push(sign)
                
                currentInputOnDisplay = digitsStack.peek()
                //output?.display(string: currentInputOnDisplay) // вывод промежуточного результата - топовый элемент стека
                correctOutput(str: currentInputOnDisplay)
                
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
                
                digitsStack.push(currentInputOnDisplay)
                
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
                
                currentInputOnDisplay = digitsStack.peek()
                //output?.display(string: currentInputOnDisplay)
                correctOutput(str: currentInputOnDisplay)
                
            case .mathOperation:   // 5+= ->10  5+5*= ->30
                
                digitsStack.push(digitsStack.peek())
                
                copyDigitsStack = digitsStack  // сохраняем копии стеков на случай отката
                copySignsStack = signsStack
                
                while !signsStack.isEmpty() && digitsStack.count() >= 2 {
                    doOperation(secondOperand: digitsStack.pop(),
                                firstOperand: digitsStack.pop(),
                                sign: signsStack.pop())
                }
                
                currentInputOnDisplay = digitsStack.peek()
                //output?.display(string: currentInputOnDisplay)
                correctOutput(str: currentInputOnDisplay)
                
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
                
                currentInputOnDisplay = digitsStack.peek()
                //output?.display(string: currentInputOnDisplay)
                correctOutput(str: currentInputOnDisplay)
                
            }
            
            
        case .clean:
            digitsStack.clean()
            signsStack.clean()
            copyDigitsStack.clean()
            copySignsStack.clean()
            currentInputOnDisplay = "0"
            
            prevState = .initial
            
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
    
    var digitsStack = StringStack()
    var signsStack = StringStack()
    var copyDigitsStack = StringStack()
    var copySignsStack = StringStack()
    
    private var prevState: InternalState = .initial
    
    var output: CalculatorModelOutput? // почему optional?
    
    private func doOperation(secondOperand: String, firstOperand: String, sign: String) {
        switch sign {
        case "+":
            digitsStack.push(String(Double(firstOperand)! + Double(secondOperand)!))
        case "-":
            digitsStack.push(String(Double(firstOperand)! - Double(secondOperand)!))
        case "×":
            digitsStack.push(String(Double(firstOperand)! * Double(secondOperand)!))
        case "÷":
            digitsStack.push(String(Double(firstOperand)! / Double(secondOperand)!))
        default:
            break
        }
    }
    
    
    private func correctOutput(str: String) {           //correct?   + округление до 9 цифр на дисплее
        let result = Double(str)! - floor(Double(str)!)
        if result == 0 {
            output?.display(string: String(Int(Double(str)!)))
        } else {
            output?.display(string: str)
        }
    }
    
    
    func input(op: Operation) {
        
       let internalState = newInternalState(op)
        processWith(state: internalState)
        
        
    
        
        
        
        
        
        /*
        switch op {
        case .digit(let digit):                                             
            if stillTyping {
                if currentInput.count < 9 {
                    output?.display(string: currentInput + digit)
                }
            } else {
                output?.display(string: digit)
                stillTyping = digit != "0" ? true : false
            }
            
            lastTapIsDigitButton = true
            firstInputIsSignOrEquality = false
            
        case .sign(let sign):
            
             // если еще вводим или первая операция с калькулятором - знак
             if lastTapIsDigitButton || firstInputIsSignOrEquality {
                 if sign == "=" && signsStack.isEmpty() && digitsStack.count() == 1 {
                     digitsStack.clean()
                 }
                 digitsStack.push(currentInput)
             }
             
             if sign == "=" {
                 // СЛУЧАЙ КОГДА SIGN_STACK = 0 и DIGITS_STACK = 1 (Например, сделали какую-нибудь операцию и получили 20 (2*10 = 20; = -> 200; = -> 2000))
                 if digitsStack.count() == 1 {
                     if signsStack.isEmpty() && !copyDigitsStack.isEmpty() && !copySignsStack.isEmpty() {
                         signsStack.push(copySignsStack.pop())
                         digitsStack.push(copyDigitsStack.pop())
                         
                 // СЛУЧАЙ КОГДА SIGN_STACK = 1 и DIGITS_STACK = 1 (Например, вводим 5+= -> 10; = -> 15; = -> 20)
                     } else if signsStack.count() == 1 {
                         digitsStack.push(digitsStack.peek())
                     }
                 }
             }
             
             //  2 + 3 * 4 - нужно откатиться, после знака равно
             
             if sign != "=" && !lastTapIsDigitButton && !firstInputIsSignOrEquality {  // откат до последней операции, если меняем знак
                     digitsStack = copyDigitsStack
                     signsStack = copySignsStack
                 
             }
                 
                 copyDigitsStack = digitsStack  // сохраняем копии стеков на случай отката
                 copySignsStack = signsStack
             
             while !signsStack.isEmpty() && digitsStack.count() >= 2 {
                 if priority(sign: signsStack.peek()) >= priority(sign: sign) || sign == "=" {
                     doOperation(secondOperand: digitsStack.pop(),
                                 firstOperand: digitsStack.pop(),
                                 sign: signsStack.pop())
                 } else {
                     break
                 }
             }
             
             output?.display(string: digitsStack.peek()) // вывод промежуточного результата - топовый элемент стека)
             
             if sign != "=" {
                 signsStack.push(sign)
             }

             stillTyping = false
             firstInputIsSignOrEquality = false
             lastTapIsDigitButton = false
            
        case .clean:
            
            lastTapIsDigitButton = false
            firstInputIsSignOrEquality = true
            stillTyping = false
            
            digitsStack.clean()
            signsStack.clean()
            copyDigitsStack.clean()
            copySignsStack.clean()
            
            output?.display(string: "0")
        
        default:
            break
        }
 */
    }
}
