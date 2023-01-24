//
//  ShadowCollectionViewCell.swift
//  My Song Comparison
//
//  Created by Jarred Davis on 1/17/23.
//

import UIKit

class ShadowCollectionViewCell: UICollectionViewCell {
    var cornerRadius: CGFloat = 5.0

    override init(frame:CGRect) {
        super.init(frame: frame)
        // Apply rounded corners to contentView
        contentView.backgroundColor = .white
        contentView.layer.cornerRadius = cornerRadius
        contentView.layer.masksToBounds = true
        
        // Set masks to bounds to false to avoid the shadow
        // from being clipped to the corner radius
        layer.cornerRadius = cornerRadius
        layer.masksToBounds = false
        
        // Apply a shadow
        layer.shadowRadius = 8.0
        layer.shadowOpacity = 0.10
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOffset = CGSize(width: 0, height: 5)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        // Improve scrolling performance with an explicit shadowPath
        layer.shadowPath = UIBezierPath(
            roundedRect: bounds,
            cornerRadius: cornerRadius
        ).cgPath
    }
}
