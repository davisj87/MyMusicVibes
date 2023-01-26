//
//  TrackDetailCollectionViewCell.swift
//  My Song Comparison
//
//  Created by Jarred Davis on 1/18/23.
//

import UIKit

class TrackDetailCollectionViewCell: ShadowCollectionViewCell {

    var trackDetail:TrackCollectionViewCellViewModel? {
        didSet {
            guard let trackDetailObj = trackDetail else { return }
            nameLabel.text = trackDetailObj.name
            valueLabel.text = trackDetailObj.value
        }
    }
    
    let nameLabel:UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 14)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let valueLabel:UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.contentView.addSubview(nameLabel)
        self.contentView.addSubview(valueLabel)
        
        valueLabel.bottomAnchor.constraint(equalTo:self.contentView.centerYAnchor).isActive = true
        valueLabel.leadingAnchor.constraint(equalTo:self.contentView.leadingAnchor, constant:10).isActive = true
        valueLabel.trailingAnchor.constraint(equalTo:self.contentView.trailingAnchor, constant:-10).isActive = true

        nameLabel.topAnchor.constraint(equalTo:self.valueLabel.bottomAnchor, constant:10).isActive = true
        nameLabel.leadingAnchor.constraint(equalTo:self.valueLabel.leadingAnchor).isActive = true
        nameLabel.trailingAnchor.constraint(equalTo:self.valueLabel.trailingAnchor).isActive = true
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
}
