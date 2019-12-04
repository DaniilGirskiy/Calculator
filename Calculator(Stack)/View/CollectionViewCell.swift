//
//  CollectionViewCell.swift
//  CalculatorByStack
//
//  Created by Danya on 30/11/2019.
//  Copyright © 2019 Daniil Girskiy. All rights reserved.
//

import UIKit

struct CollectionViewCellViewModel {
    let titleText: String
    let backgroundColor: UIColor
    let titleColor: UIColor
}


class CollectionViewCell: UICollectionViewCell {
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var containerView: UIView!
    
    
    var viewModel: CollectionViewCellViewModel? {
        didSet {
            guard let viewModel = viewModel else { return }
            
            titleLabel.text = viewModel.titleText
            containerView.backgroundColor = viewModel.backgroundColor
            titleLabel.textColor = viewModel.titleColor
        }
    }
    
    
    override func layoutSubviews() {
        //print("хуй пизда \(frame)")
        containerView.layer.cornerRadius = containerView.frame.height / 2
    }
   

}
