//
//  Stack.swift
//  Calculator(Stack)
//
//  Created by Danya on 08/11/2019.
//  Copyright © 2019 Daniil Girskiy. All rights reserved.
//

import Foundation

struct StringStack {
    private var array: [String] = []
    
    func isEmpty() -> Bool {
        return array.isEmpty ? true : false
    }
    
    func peek() -> String {
        guard let topElement = array.first else { fatalError("The stack is empty.") }
        return topElement
    }
    
    func count() -> Int {
        return array.count
    }
    
    mutating func clean() {
        array.removeAll()
    }
    
    mutating func pop() -> String {
        return array.removeFirst()
    }
    
    mutating func push(_ element: String) {
        array.insert(element, at: 0)
    }
}


struct numberStack {
    private var array: [Double] = []
}


extension StringStack: CustomStringConvertible {
    var description: String {
        let topDivider = "---Stack---\n"
        let bottomDivider = "\n-----------\n"
        
        let stackElements = array.joined(separator: "\n")
        
        return topDivider + stackElements + bottomDivider
    }
}





func priority(sign: String) -> Int {
    if sign == "-" || sign == "+" {
        return 1
    } else {
        return 2
    }
}

//NumberFormatter(Decimal)!!!!!!!!!!!!!!!
// функция floor
