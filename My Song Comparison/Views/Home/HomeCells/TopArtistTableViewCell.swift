//
//  TopArtistTableViewCell.swift
//  My Song Comparison
//
//  Created by Jarred Davis on 1/16/23.
//

import UIKit

class TopArtistTableViewCell: ShadowTableViewCell {
    
    var artist:TopArtistsObject? {
        didSet {
            guard let artistObject = artist else { return }
            nameLabel.text = artistObject.name
            popLabel.text = "Pop:\n \(artistObject.popularity)"
            popLabel.numberOfLines = 2
            let genres = artistObject.genres.joined(separator: ", ")
            genreLabel.text = genres
            genreLabel.numberOfLines = 2
            guard !artistObject.images.isEmpty else { return }
            let thumbUrl = artistObject.images[0].url
            Task {
                do {
                    artistImageView.image = try await UIImage().loadImage(thumbUrl)
                }catch {
                    print ("image didnt load")
                }
            }
        }
    }
    
    private let artistImageView:UIImageView = {
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
    
    private let genreLabel:UILabel = {
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
    
        self.containerView.addSubview(artistImageView)
        self.containerView.addSubview(nameLabel)
        self.containerView.addSubview(genreLabel)
        self.containerView.addSubview(popLabel)

        popLabel.widthAnchor.constraint(equalToConstant:30).isActive = true
        popLabel.trailingAnchor.constraint(equalTo:self.containerView.trailingAnchor, constant:-10).isActive = true
        popLabel.bottomAnchor.constraint(equalTo:self.containerView.bottomAnchor).isActive = true
        popLabel.topAnchor.constraint(equalTo:self.containerView.topAnchor).isActive = true
        
        artistImageView.centerYAnchor.constraint(equalTo:containerView.centerYAnchor).isActive = true
        artistImageView.leadingAnchor.constraint(equalTo:containerView.leadingAnchor, constant:10).isActive = true
        artistImageView.widthAnchor.constraint(equalToConstant:70).isActive = true
        artistImageView.heightAnchor.constraint(equalToConstant:70).isActive = true
        
        nameLabel.bottomAnchor.constraint(equalTo:self.containerView.centerYAnchor).isActive = true
        nameLabel.leadingAnchor.constraint(equalTo:self.artistImageView.trailingAnchor, constant:10).isActive = true
        nameLabel.trailingAnchor.constraint(equalTo:self.popLabel.leadingAnchor, constant:-10).isActive = true

        genreLabel.topAnchor.constraint(equalTo:self.nameLabel.bottomAnchor).isActive = true
        genreLabel.leadingAnchor.constraint(equalTo:self.nameLabel.leadingAnchor).isActive = true
        genreLabel.trailingAnchor.constraint(equalTo:self.popLabel.leadingAnchor, constant:-10).isActive = true
        
        
     }
     required init?(coder aDecoder: NSCoder) {
         super.init(coder: aDecoder)
    }

}
