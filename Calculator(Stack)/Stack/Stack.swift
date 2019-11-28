//
//  Stack.swift
//  Calculator(Stack)
//
//  Created by Danya on 08/11/2019.
//  Copyright © 2019 Daniil Girskiy. All rights reserved.
//

import Foundation

struct Stack<Element> {                  // mark
    private var array = [Element]()
    
    func isEmpty() -> Bool {
        return array.isEmpty ? true : false
    }
    
    func peek() -> Element {
        guard let topElement = array.first else { fatalError("The stack is empty.") }
        return topElement
    }
    
    func count() -> Int {
        return array.count
    }
    
    mutating func clean() {
        array.removeAll()
    }
    
    mutating func pop() -> Element {
        return array.removeFirst()
    }
    
    mutating func push(_ element: Element) {
        array.insert(element, at: 0)
    }
}


/*
extension Stack: CustomStringConvertible {
    var description: String {
        let topDivider = "---Stack---\n"
        let bottomDivider = "\n-----------\n"
        
        let stackElements = array.joined(separator: "\n")
        
        return topDivider + stackElements + bottomDivider
    }
}
*/




func priority(sign: String) -> Int {
    if sign == "-" || sign == "+" {
        return 1
    } else {
        return 2
    }
}

//NumberFormatter(Decimal)!!!!!!!!!!!!!!!
// функция floor
