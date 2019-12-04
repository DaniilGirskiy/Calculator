//
//  Calculator_Stack_Tests.swift
//  Calculator(Stack)Tests
//
//  Created by Danya on 23/11/2019.
//  Copyright © 2019 Daniil Girskiy. All rights reserved.
//

import XCTest
@testable import CalculatorByStack // ???
//import CoreData
//import Foundation
//import SwiftOnoneSupport
//import UIKit

class MockOutput: CalculatorModelOutput {
    var testOutput = ""
    func display(string: String) {
        testOutput = string
    }
}

class Calculator_Stack_Tests: XCTestCase {
    private var calcModel: CalculatorModel!
    
    override func setUp() {
        calcModel = CalculatorAssembly().model
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        calcModel = nil
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testOutput() {
        let output = MockOutput()
        calcModel.output = output
        // when
        calcModel.input(op: .digit(1))
        calcModel.input(op: .digit(1))
        //then
        XCTAssert(output.testOutput == "11", "Обоссамс")
    }

    

}
