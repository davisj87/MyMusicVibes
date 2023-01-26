//
//  TrackDetailHeaderCollectionReusableView.swift
//  My Song Comparison
//
//  Created by Jarred Davis on 1/18/23.
//

import UIKit

class TrackDetailHeaderCollectionReusableView: UICollectionReusableView {
    static let identifier = "trackDetailHeaderCollectionReusableView"
    
    var section:TrackCollectionViewSectionViewModel? {
        didSet {
            guard let section = section else { return }
            sectionLabel.text = section.title
        }
    }
    
    private let sectionLabel: UILabel = {
        let label = UILabel()
        label.text = "Header"
        label.textColor = .black
        label.font = UIFont.boldSystemFont(ofSize: 24)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
        
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        addSubview(sectionLabel)
        
        sectionLabel.centerYAnchor.constraint(equalTo:self.centerYAnchor).isActive = true
        sectionLabel.leadingAnchor.constraint(equalTo:self.leadingAnchor, constant:10).isActive = true
        sectionLabel.trailingAnchor.constraint(equalTo:self.trailingAnchor, constant:-10).isActive = true
        
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
}

class TrackDetailFooterCollectionReusableView: UICollectionReusableView {
    static let identifier = "trackDetailFooterCollectionReusableView"
    
    func configure() {
        backgroundColor = .clear
    }
    
    
}
