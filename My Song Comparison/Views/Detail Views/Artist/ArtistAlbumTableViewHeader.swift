//
//  ArtistAlbumTableViewHeader.swift
//  My Song Comparison
//
//  Created by Jarred Davis on 2/1/23.
//

import UIKit

class ArtistAlbumTableViewHeaderCell: UITableViewCell {
    
    var artist:ArtistCellViewModel? {
        didSet {
            guard let artist = artist else { return }
            artistLabel.text = artist.primaryText
            genreLabel.text = "Genres: " + artist.secondaryText
            popularityLabel.text = "Popularity: " + artist.popularity
            followerLabel.text = "Followers: " + artist.additionalDetailText
            Task {
                do {
                    trackImageView.image = try await UIImage().loadImage(artist.imageUrl)
                }catch {
                    print ("image didnt load")
                }
            }
        }
    }

    private let artistLabel:UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        return label
    }()

    private let followerLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = UIFont.boldSystemFont(ofSize: 12)
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
    
    private let genreLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 2
        label.textAlignment = .center
        return label
    }()
    
    private let popularityLabel: UILabel = {
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
        addSubview(artistLabel)
        addSubview(followerLabel)
        addSubview(trackImageView)
        addSubview(genreLabel)
        addSubview(popularityLabel)
        
        
        artistLabel.topAnchor.constraint(equalTo:self.topAnchor, constant: 10).isActive = true
        artistLabel.leadingAnchor.constraint(equalTo:self.leadingAnchor, constant:10).isActive = true
        artistLabel.trailingAnchor.constraint(equalTo:self.trailingAnchor, constant:-10).isActive = true
        
        followerLabel.topAnchor.constraint(equalTo:self.artistLabel.bottomAnchor, constant: 2).isActive = true
        followerLabel.leadingAnchor.constraint(equalTo:self.leadingAnchor, constant:10).isActive = true
        followerLabel.trailingAnchor.constraint(equalTo:self.trailingAnchor, constant:-10).isActive = true
        
        trackImageView.topAnchor.constraint(equalTo:self.followerLabel.bottomAnchor, constant: 10).isActive = true
        trackImageView.centerXAnchor.constraint(equalTo:self.centerXAnchor).isActive = true
        trackImageView.widthAnchor.constraint(equalToConstant:100).isActive = true
        trackImageView.heightAnchor.constraint(equalToConstant:100).isActive = true
        
        genreLabel.topAnchor.constraint(equalTo:self.trackImageView.bottomAnchor, constant: 20).isActive = true
        genreLabel.leadingAnchor.constraint(equalTo:self.leadingAnchor, constant:10).isActive = true
        genreLabel.trailingAnchor.constraint(equalTo:self.trailingAnchor, constant:-10).isActive = true
        
        popularityLabel.topAnchor.constraint(equalTo:self.genreLabel.bottomAnchor, constant: 4).isActive = true
        popularityLabel.leadingAnchor.constraint(equalTo:self.leadingAnchor, constant:10).isActive = true
        popularityLabel.trailingAnchor.constraint(equalTo:self.trailingAnchor, constant:-10).isActive = true
        
        self.layer.shadowOpacity = 0.1
        self.layer.shadowOffset = CGSize(width: 0, height: 3)
        self.layer.shadowRadius = 2
        
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

}
