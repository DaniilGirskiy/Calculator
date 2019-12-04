//
//  AppDelegate.swift
//  Calculator(Stack)
//
//  Created by Danya on 08/11/2019.
//  Copyright © 2019 Daniil Girskiy. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        window = UIWindow()
        let assembly = CalculatorAssembly()
        let model = assembly.model
        let viewController = assembly.calculatorCollectionController(with: model)
        window?.rootViewController = viewController
        window?.makeKeyAndVisible()
        
        // Override point for customization after application launch.
        return true
    }

}

