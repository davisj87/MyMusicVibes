//
//  TrackDetailTableViewCell.swift
//  My Song Comparison
//
//  Created by Jarred Davis on 1/20/23.
//

import UIKit

class TrackDetailTableViewCell: ShadowTableViewCell {
    var track:TrackViewModel? {
        didSet {
            guard let track = track else { return }
            nameLabel.text = track.name
            artistLabel.text = track.artist
            popLabel.text = track.popularity
            popLabel.numberOfLines = 2
            
            valenceValueLabel.text = track.valence.value
            dancabilityValueLabel.text = track.dancability.value
            keyValueLabel.text = track.keyMode.value
            
            
            guard track.imageUrlString != "" else { return }
            Task {
                do {
                    trackImageView.image = try await UIImage().loadImage(track.imageUrlString)
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
    
    private let valenceTitleLabel:UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 12)
        label.text = "Mood:"
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let valenceValueLabel:UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let dancabilityTitleLabel:UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 12)
        label.text = "Danceability:"
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let dancabilityValueLabel:UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let keyTitleLabel:UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 12)
        label.text = "Key:"
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let keyValueLabel:UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    
        self.containerView.addSubview(trackImageView)
        self.containerView.addSubview(nameLabel)
        self.containerView.addSubview(artistLabel)
        self.containerView.addSubview(popLabel)
        
        self.containerView.addSubview(valenceTitleLabel)
        self.containerView.addSubview(valenceValueLabel)
        
        self.containerView.addSubview(dancabilityTitleLabel)
        self.containerView.addSubview(dancabilityValueLabel)
        
        self.containerView.addSubview(keyTitleLabel)
        self.containerView.addSubview(keyValueLabel)
        

        popLabel.widthAnchor.constraint(equalToConstant:30).isActive = true
        popLabel.trailingAnchor.constraint(equalTo:self.containerView.trailingAnchor, constant:-10).isActive = true
        popLabel.topAnchor.constraint(equalTo:self.containerView.topAnchor, constant: 20).isActive = true

        trackImageView.topAnchor.constraint(equalTo:containerView.topAnchor, constant: 10).isActive = true
        trackImageView.leadingAnchor.constraint(equalTo:containerView.leadingAnchor, constant:10).isActive = true
        trackImageView.widthAnchor.constraint(equalToConstant:70).isActive = true
        trackImageView.heightAnchor.constraint(equalToConstant:70).isActive = true
        
        nameLabel.topAnchor.constraint(equalTo:self.containerView.topAnchor, constant: 20).isActive = true
        nameLabel.leadingAnchor.constraint(equalTo:self.trackImageView.trailingAnchor, constant:10).isActive = true
        nameLabel.trailingAnchor.constraint(equalTo:self.popLabel.leadingAnchor, constant:-10).isActive = true

        artistLabel.topAnchor.constraint(equalTo:self.nameLabel.bottomAnchor).isActive = true
        artistLabel.leadingAnchor.constraint(equalTo:self.nameLabel.leadingAnchor).isActive = true
        artistLabel.trailingAnchor.constraint(equalTo:self.popLabel.leadingAnchor, constant:-10).isActive = true
        
        valenceTitleLabel.topAnchor.constraint(equalTo:self.trackImageView.bottomAnchor, constant: 20).isActive = true
        valenceTitleLabel.leadingAnchor.constraint(equalTo:self.containerView.leadingAnchor, constant:10).isActive = true
        valenceTitleLabel.widthAnchor.constraint(equalToConstant:100).isActive = true
        
        valenceValueLabel.topAnchor.constraint(equalTo:self.valenceTitleLabel.bottomAnchor).isActive = true
        valenceValueLabel.leadingAnchor.constraint(equalTo:self.containerView.leadingAnchor, constant:10).isActive = true
        valenceValueLabel.widthAnchor.constraint(equalToConstant:100).isActive = true
        
        dancabilityTitleLabel.topAnchor.constraint(equalTo:self.trackImageView.bottomAnchor, constant: 20).isActive = true
        dancabilityTitleLabel.centerXAnchor.constraint(equalTo:self.containerView.centerXAnchor).isActive = true
        dancabilityTitleLabel.widthAnchor.constraint(equalToConstant:100).isActive = true
        
        dancabilityValueLabel.topAnchor.constraint(equalTo:self.dancabilityTitleLabel.bottomAnchor).isActive = true
        dancabilityValueLabel.centerXAnchor.constraint(equalTo:self.containerView.centerXAnchor).isActive = true
        dancabilityValueLabel.widthAnchor.constraint(equalToConstant:100).isActive = true
        
        keyTitleLabel.topAnchor.constraint(equalTo:self.trackImageView.bottomAnchor, constant: 20).isActive = true
        keyTitleLabel.trailingAnchor.constraint(equalTo:self.containerView.trailingAnchor, constant:-10).isActive = true
        keyTitleLabel.widthAnchor.constraint(equalToConstant:100).isActive = true
        
        keyValueLabel.topAnchor.constraint(equalTo:self.keyTitleLabel.bottomAnchor).isActive = true
        keyValueLabel.trailingAnchor.constraint(equalTo:self.keyTitleLabel.trailingAnchor).isActive = true
        keyValueLabel.widthAnchor.constraint(equalToConstant:100).isActive = true
        
        
     }
     required init?(coder aDecoder: NSCoder) {
         super.init(coder: aDecoder)
    }

}

