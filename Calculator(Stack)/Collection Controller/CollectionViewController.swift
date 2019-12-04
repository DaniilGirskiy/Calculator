//
//  CollectionViewController.swift
//  CalculatorByStack
//
//  Created by Danya on 30/11/2019.
//  Copyright © 2019 Daniil Girskiy. All rights reserved.
//

import UIKit

class CollectionViewController: UIViewController {
    @IBOutlet weak var displayLabel: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!
    
    var buttons: [CollectionViewCellViewModel] = .generate()
    
    var model: CalculatorModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let nib = UINib(nibName: "CollectionViewCell", bundle: nil)
        collectionView.register(nib, forCellWithReuseIdentifier: "cell")
        collectionView.dataSource = self
        collectionView.delegate = self
        
        model?.output = self
    }
}

extension CollectionViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vm = buttons[indexPath.item]
        print(vm.titleText)
        
        
        switch vm.titleText {
        case "AC":
            model?.input(op: .clean)
        case ",":
            model?.input(op: .dot)
        case "=":
            model?.input(op: .result)
        case "+":
            model?.input(op: .sign(.plus))
        case "-":
            model?.input(op: .sign(.minus))
        case "×":
            model?.input(op: .sign(.multiply))
        case "÷":
            model?.input(op: .sign(.divide))
        case "0":
            model?.input(op: .digit(0))
        case "1":
            model?.input(op: .digit(1))
        case "2":
            model?.input(op: .digit(2))
        case "3":
            model?.input(op: .digit(3))
        case "4":
            model?.input(op: .digit(4))
        case "5":
            model?.input(op: .digit(5))
        case "6":
            model?.input(op: .digit(6))
        case "7":
            model?.input(op: .digit(7))
        case "8":
            model?.input(op: .digit(8))
        case "9":
            model?.input(op: .digit(9))
        default:
            break
        }
    }
}


extension CollectionViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return buttons.count
       }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! CollectionViewCell
        
//        let vm = CollectionViewCellViewModel(titleText: "\(indexPath.item)", backgroundColor: indexPath.item % 2 == 0 ? .yellow : .blue)
        
        let vm = buttons[indexPath.item]
        
        cell.viewModel = vm
        return cell
    }
}

extension CollectionViewController: CalculatorModelOutput {
    func display(string: String) {
        displayLabel.text = string
    }
    
}
