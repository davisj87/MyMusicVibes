//
//  PlaylistTableViewHeader.swift
//  My Song Comparison
//
//  Created by Jarred Davis on 2/1/23.
//

import UIKit

class PlaylistTableViewHeader: UIView {
            
    var playlist:PlaylistCellViewModel? {
        didSet {
            guard let playlist = playlist else { return }
            nameLabel.text = playlist.primaryText
            ownerLabel.text = playlist.secondaryText
            guard playlist.imageUrl != "" else { return }
            Task {
                do {
                    trackImageView.image = try await UIImage().loadImage(playlist.imageUrl)
                }catch {
                    print ("image didnt load")
                }
            }
        }
    }

    private let nameLabel:UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.numberOfLines = 2
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        return label
    }()

    private let trackImageView:UIImageView = {
        let img = UIImageView()
        img.contentMode = .scaleAspectFill
        img.translatesAutoresizingMaskIntoConstraints = false // enable autolayout
        img.layer.cornerRadius = 35
        img.clipsToBounds = true
        return img
    }()
    
    private let ownerLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 2
        label.textAlignment = .center
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white

        addSubview(nameLabel)
        addSubview(trackImageView)
        addSubview(ownerLabel)
        
        
        nameLabel.topAnchor.constraint(equalTo:self.topAnchor, constant: 10).isActive = true
        nameLabel.leadingAnchor.constraint(equalTo:self.leadingAnchor, constant:10).isActive = true
        nameLabel.trailingAnchor.constraint(equalTo:self.trailingAnchor, constant:-10).isActive = true
        
        trackImageView.topAnchor.constraint(equalTo:self.nameLabel.bottomAnchor, constant: 10).isActive = true
        trackImageView.centerXAnchor.constraint(equalTo:self.centerXAnchor).isActive = true
        trackImageView.widthAnchor.constraint(equalToConstant:100).isActive = true
        trackImageView.heightAnchor.constraint(equalToConstant:100).isActive = true
        
        ownerLabel.topAnchor.constraint(equalTo:self.trackImageView.bottomAnchor, constant: 20).isActive = true
        ownerLabel.leadingAnchor.constraint(equalTo:self.leadingAnchor, constant:10).isActive = true
        ownerLabel.trailingAnchor.constraint(equalTo:self.trailingAnchor, constant:-10).isActive = true
        
        self.layer.shadowOpacity = 0.1
        self.layer.shadowOffset = CGSize(width: 0, height: 3)
        self.layer.shadowRadius = 2
        
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

}
