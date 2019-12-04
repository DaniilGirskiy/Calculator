//
//  CollectionViewCellViewModelGenerator.swift
//  CalculatorByStack
//
//  Created by Danya on 30/11/2019.
//  Copyright © 2019 Daniil Girskiy. All rights reserved.
//

import Foundation

extension Array where Element == CollectionViewCellViewModel { // и тд
    static func generate() -> [CollectionViewCellViewModel] {
        return [CollectionViewCellViewModel(titleText: "AC", backgroundColor: .systemGray3, titleColor: .black),
                CollectionViewCellViewModel(titleText: "+/-", backgroundColor: .systemGray3, titleColor: .black),
                CollectionViewCellViewModel(titleText: "%", backgroundColor: .systemGray3, titleColor: .black),
                CollectionViewCellViewModel(titleText: "÷", backgroundColor: .systemOrange, titleColor: .white),
                CollectionViewCellViewModel(titleText: "7", backgroundColor: .gray, titleColor: .white),
                CollectionViewCellViewModel(titleText: "8", backgroundColor: .gray, titleColor: .white),
                CollectionViewCellViewModel(titleText: "9", backgroundColor: .gray, titleColor: .white),
                CollectionViewCellViewModel(titleText: "×", backgroundColor: .systemOrange, titleColor: .white),
                CollectionViewCellViewModel(titleText: "4", backgroundColor: .gray, titleColor: .white),
                CollectionViewCellViewModel(titleText: "5", backgroundColor: .gray, titleColor: .white),
                CollectionViewCellViewModel(titleText: "6", backgroundColor: .gray, titleColor: .white),
                CollectionViewCellViewModel(titleText: "-", backgroundColor: .systemOrange, titleColor: .white),
                CollectionViewCellViewModel(titleText: "1", backgroundColor: .gray, titleColor: .white),
                CollectionViewCellViewModel(titleText: "2", backgroundColor: .gray, titleColor: .white),
                CollectionViewCellViewModel(titleText: "3", backgroundColor: .gray, titleColor: .white),
                CollectionViewCellViewModel(titleText: "+", backgroundColor: .systemOrange, titleColor: .white),
                CollectionViewCellViewModel(titleText: "0", backgroundColor: .gray, titleColor: .white),
                CollectionViewCellViewModel(titleText: ",", backgroundColor: .gray, titleColor: .white),
                CollectionViewCellViewModel(titleText: "=", backgroundColor: .systemOrange, titleColor: .white)]
    }
}
