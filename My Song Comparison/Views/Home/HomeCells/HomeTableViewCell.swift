//
//  TopArtistTableViewCell.swift
//  My Song Comparison
//
//  Created by Jarred Davis on 1/16/23.
//

import UIKit

class HomeTableViewCell: ShadowTableViewCell {
    
    var homeCellViewModel:ItemOverviewCellViewModelProtocol? {
        didSet {
            guard let homeCellViewModel = homeCellViewModel else { return }
            primaryLabel.text = homeCellViewModel.primaryText
            popLabel.text = "Pop:\n" + homeCellViewModel.popularity
            popLabel.numberOfLines = 2
            secondaryLabel.text = homeCellViewModel.secondaryText
            secondaryLabel.numberOfLines = 2
            guard homeCellViewModel.imageUrl != "" else { return }
            Task {
                do {
                    pictureView.image = try await UIImage().loadImage(homeCellViewModel.imageUrl)
                }catch {
                    print ("image didnt load")
                }
            }
        }
    }
    
    private let pictureView:UIImageView = {
        let img = UIImageView()
        img.contentMode = .scaleAspectFill
        img.translatesAutoresizingMaskIntoConstraints = false // enable autolayout
        img.layer.cornerRadius = 35
        img.clipsToBounds = true
        return img
    }()
    
    private let primaryLabel:UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let secondaryLabel:UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 14)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let popLabel:UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 10)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    
        self.containerView.addSubview(pictureView)
        self.containerView.addSubview(primaryLabel)
        self.containerView.addSubview(secondaryLabel)
        self.containerView.addSubview(popLabel)

        popLabel.widthAnchor.constraint(equalToConstant:30).isActive = true
        popLabel.trailingAnchor.constraint(equalTo:self.containerView.trailingAnchor, constant:-10).isActive = true
        popLabel.bottomAnchor.constraint(equalTo:self.containerView.bottomAnchor).isActive = true
        popLabel.topAnchor.constraint(equalTo:self.containerView.topAnchor).isActive = true
        
        pictureView.centerYAnchor.constraint(equalTo:containerView.centerYAnchor).isActive = true
        pictureView.leadingAnchor.constraint(equalTo:containerView.leadingAnchor, constant:10).isActive = true
        pictureView.widthAnchor.constraint(equalToConstant:70).isActive = true
        pictureView.heightAnchor.constraint(equalToConstant:70).isActive = true
        
        primaryLabel.bottomAnchor.constraint(equalTo:self.containerView.centerYAnchor).isActive = true
        primaryLabel.leadingAnchor.constraint(equalTo:self.pictureView.trailingAnchor, constant:10).isActive = true
        primaryLabel.trailingAnchor.constraint(equalTo:self.popLabel.leadingAnchor, constant:-10).isActive = true

        secondaryLabel.topAnchor.constraint(equalTo:self.primaryLabel.bottomAnchor).isActive = true
        secondaryLabel.leadingAnchor.constraint(equalTo:self.primaryLabel.leadingAnchor).isActive = true
        secondaryLabel.trailingAnchor.constraint(equalTo:self.popLabel.leadingAnchor, constant:-10).isActive = true
        
        
     }
     required init?(coder aDecoder: NSCoder) {
         super.init(coder: aDecoder)
    }

}
