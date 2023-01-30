//
//  TopPlaylistTableViewCell.swift
//  My Song Comparison
//
//  Created by Jarred Davis on 1/17/23.
//

import UIKit

class TopPlaylistTableViewCell:ShadowTableViewCell {
    var playlist:ItemOverviewCellViewModelProtocol? {
        didSet {
            guard let playlistObject = playlist else { return }
            nameLabel.text = playlistObject.primaryText
            ownerLabel.text = playlistObject.secondaryText
            guard playlistObject.imageUrl != "" else { return }
            Task {
                do {
                    playlistImageView.image = try await UIImage().loadImage(playlistObject.imageUrl)
                }catch {
                    print ("image didnt load")
                }
            }
        }
    }
    
    private let playlistImageView:UIImageView = {
        let img = UIImageView()
        img.contentMode = .scaleAspectFill
        img.translatesAutoresizingMaskIntoConstraints = false // enable autolayout
        img.layer.cornerRadius = 35
        img.clipsToBounds = true
        return img
    }()
    
    private let nameLabel:UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let ownerLabel:UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 14)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    
        self.containerView.addSubview(playlistImageView)
        self.containerView.addSubview(nameLabel)
        self.containerView.addSubview(ownerLabel)

        playlistImageView.centerYAnchor.constraint(equalTo:containerView.centerYAnchor).isActive = true
        playlistImageView.leadingAnchor.constraint(equalTo:containerView.leadingAnchor, constant:10).isActive = true
        playlistImageView.widthAnchor.constraint(equalToConstant:70).isActive = true
        playlistImageView.heightAnchor.constraint(equalToConstant:70).isActive = true
        
        nameLabel.bottomAnchor.constraint(equalTo:self.containerView.centerYAnchor).isActive = true
        nameLabel.leadingAnchor.constraint(equalTo:self.playlistImageView.trailingAnchor, constant:10).isActive = true
        nameLabel.trailingAnchor.constraint(equalTo:self.containerView.trailingAnchor, constant:-10).isActive = true

        ownerLabel.topAnchor.constraint(equalTo:self.nameLabel.bottomAnchor).isActive = true
        ownerLabel.leadingAnchor.constraint(equalTo:self.nameLabel.leadingAnchor).isActive = true
        ownerLabel.trailingAnchor.constraint(equalTo:self.containerView.trailingAnchor, constant:-10).isActive = true
        
        
     }
     required init?(coder aDecoder: NSCoder) {
         super.init(coder: aDecoder)
    }

}
