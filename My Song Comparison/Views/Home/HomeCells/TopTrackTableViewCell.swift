//
//  TopTrackTableViewCell.swift
//  My Song Comparison
//
//  Created by Jarred Davis on 1/17/23.
//

import UIKit

class TopTrackTableViewCell: ShadowTableViewCell {
    var track:TracksObject? {
        didSet {
            guard let trackObject = track else { return }
            nameLabel.text = trackObject.name
            artistLabel.text = trackObject.artists.isEmpty ? "" : trackObject.artists[0].name
            popLabel.text = "Pop:\n \(trackObject.popularity)"
            popLabel.numberOfLines = 2
            guard !trackObject.album.images.isEmpty else { return }
            let thumbUrl = trackObject.album.images[0].url
            Task {
                do {
                    trackImageView.image = try await UIImage().loadImage(thumbUrl)
                }catch {
                    print ("image didnt load")
                }
            }
        }
    }
    
    private let trackImageView:UIImageView = {
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
    
    private let artistLabel:UILabel = {
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
    
        self.containerView.addSubview(trackImageView)
        self.containerView.addSubview(nameLabel)
        self.containerView.addSubview(artistLabel)
        self.containerView.addSubview(popLabel)

        popLabel.widthAnchor.constraint(equalToConstant:30).isActive = true
        popLabel.trailingAnchor.constraint(equalTo:self.containerView.trailingAnchor, constant:-10).isActive = true
        popLabel.bottomAnchor.constraint(equalTo:self.containerView.bottomAnchor).isActive = true
        popLabel.topAnchor.constraint(equalTo:self.containerView.topAnchor).isActive = true

        trackImageView.centerYAnchor.constraint(equalTo:containerView.centerYAnchor).isActive = true
        trackImageView.leadingAnchor.constraint(equalTo:containerView.leadingAnchor, constant:10).isActive = true
        trackImageView.widthAnchor.constraint(equalToConstant:70).isActive = true
        trackImageView.heightAnchor.constraint(equalToConstant:70).isActive = true
        
        nameLabel.bottomAnchor.constraint(equalTo:self.containerView.centerYAnchor).isActive = true
        nameLabel.leadingAnchor.constraint(equalTo:self.trackImageView.trailingAnchor, constant:10).isActive = true
        nameLabel.trailingAnchor.constraint(equalTo:self.popLabel.leadingAnchor, constant:-10).isActive = true

        artistLabel.topAnchor.constraint(equalTo:self.nameLabel.bottomAnchor).isActive = true
        artistLabel.leadingAnchor.constraint(equalTo:self.nameLabel.leadingAnchor).isActive = true
        artistLabel.trailingAnchor.constraint(equalTo:self.popLabel.leadingAnchor, constant:-10).isActive = true
        
        
     }
     required init?(coder aDecoder: NSCoder) {
         super.init(coder: aDecoder)
    }

}
