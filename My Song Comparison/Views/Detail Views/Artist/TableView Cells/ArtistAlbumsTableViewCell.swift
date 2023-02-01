//
//  ArtistAlbumsTableViewCell.swift
//  My Song Comparison
//
//  Created by Jarred Davis on 1/21/23.
//

import UIKit

class ArtistAlbumsTableViewCell: ShadowTableViewCell {
    var album:AlbumCellViewModel? {
        didSet {
            guard let albumObject = album else { return }
            nameLabel.text = albumObject.primaryText
            releaseDateLabel.text = albumObject.secondaryText
            guard albumObject.imageUrl != "" else { return }
            Task {
                do {
                    albumImageView.image = try await UIImage().loadImage(albumObject.imageUrl)
                }catch {
                    print ("image didnt load")
                }
            }
        }
    }
    
    private let albumImageView:UIImageView = {
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
    
    private let releaseDateLabel:UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 14)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    
        self.containerView.addSubview(albumImageView)
        self.containerView.addSubview(nameLabel)
        self.containerView.addSubview(releaseDateLabel)

        albumImageView.centerYAnchor.constraint(equalTo:containerView.centerYAnchor).isActive = true
        albumImageView.leadingAnchor.constraint(equalTo:containerView.leadingAnchor, constant:10).isActive = true
        albumImageView.widthAnchor.constraint(equalToConstant:70).isActive = true
        albumImageView.heightAnchor.constraint(equalToConstant:70).isActive = true
        
        nameLabel.bottomAnchor.constraint(equalTo:self.containerView.centerYAnchor).isActive = true
        nameLabel.leadingAnchor.constraint(equalTo:self.albumImageView.trailingAnchor, constant:10).isActive = true
        nameLabel.trailingAnchor.constraint(equalTo:self.containerView.trailingAnchor, constant:-10).isActive = true

        releaseDateLabel.topAnchor.constraint(equalTo:self.nameLabel.bottomAnchor).isActive = true
        releaseDateLabel.leadingAnchor.constraint(equalTo:self.nameLabel.leadingAnchor).isActive = true
        releaseDateLabel.trailingAnchor.constraint(equalTo:self.containerView.trailingAnchor, constant:-10).isActive = true
        
        
     }
     required init?(coder aDecoder: NSCoder) {
         super.init(coder: aDecoder)
    }

}
