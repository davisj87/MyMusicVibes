//
//  AlbumTracksTableViewHeader.swift
//  My Song Comparison
//
//  Created by Jarred Davis on 2/1/23.
//

import UIKit

final class AlbumTracksTableViewHeaderCell: ShadowTableViewCell {
    func configure(_ albumCellViewModel:AlbumCellViewModel?) {
        guard let album = albumCellViewModel else { return }
        albumLabel.text = album.primaryText
        artistLabel.text = album.secondaryText
        releaseLabel.text = "Released: " + album.additionalDetailText
        Task {
            do {
                trackImageView.image = try await UIImage().loadImage(album.imageUrl)
            }catch {
                print ("image didnt load")
            }
        }
    }

    private let albumLabel:UILabel = {
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
    
    private let artistLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 2
        label.textAlignment = .center
        return label
    }()
    
    private let releaseLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = UIFont.boldSystemFont(ofSize: 12)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        return label
        
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .none
        addSubview(albumLabel)
        addSubview(trackImageView)
        addSubview(artistLabel)
        addSubview(releaseLabel)
        
        
        albumLabel.topAnchor.constraint(equalTo:self.containerView.topAnchor, constant: 10).isActive = true
        albumLabel.leadingAnchor.constraint(equalTo:self.containerView.leadingAnchor, constant:10).isActive = true
        albumLabel.trailingAnchor.constraint(equalTo:self.containerView.trailingAnchor, constant:-10).isActive = true
        
        trackImageView.topAnchor.constraint(equalTo:self.albumLabel.bottomAnchor, constant: 10).isActive = true
        trackImageView.centerXAnchor.constraint(equalTo:self.containerView.centerXAnchor).isActive = true
        trackImageView.widthAnchor.constraint(equalToConstant:100).isActive = true
        trackImageView.heightAnchor.constraint(equalToConstant:100).isActive = true
        
        artistLabel.topAnchor.constraint(equalTo:self.trackImageView.bottomAnchor, constant: 20).isActive = true
        artistLabel.leadingAnchor.constraint(equalTo:self.containerView.leadingAnchor, constant:10).isActive = true
        artistLabel.trailingAnchor.constraint(equalTo:self.containerView.trailingAnchor, constant:-10).isActive = true
        
        releaseLabel.topAnchor.constraint(equalTo:self.artistLabel.bottomAnchor, constant: 4).isActive = true
        releaseLabel.leadingAnchor.constraint(equalTo:self.containerView.leadingAnchor, constant:10).isActive = true
        releaseLabel.trailingAnchor.constraint(equalTo:self.containerView.trailingAnchor, constant:-10).isActive = true
        
//        self.layer.shadowOpacity = 0.1
//        self.layer.shadowOffset = CGSize(width: 0, height: 3)
//        self.layer.shadowRadius = 2
        
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

}
