//
//  TrackCollectionReusableView.swift
//  My Song Comparison
//
//  Created by Jarred Davis on 1/18/23.
//

import UIKit

class TrackCollectionReusableView: UICollectionReusableView {
    static let identifier = "trackHeaderCollectionReusableView"
    
    var track:TracksObject? {
        didSet {
            guard let track = track else { return }
            if !track.artists.isEmpty {
                artistLabel.text = track.artists[0].name
            }
            albumLabel.text = track.album.name
            guard !track.album.images.isEmpty else { return }
            let thumbUrl = track.album.images[0].url
            Task {
                do {
                    trackImageView.image = try await UIImage().loadImage(thumbUrl)
                }catch {
                    print ("image didnt load")
                }
            }
        }
    }
    
    var section:TrackCollectionViewSectionViewModel? {
        didSet {
            guard let section = section else { return }
            sectionLabel.text = section.title
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
    
    private let artistLabel:UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        return label
    }()
    
    private let albumLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = UIFont.boldSystemFont(ofSize: 12)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        return label
    }()
    
    private let sectionLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = UIFont.boldSystemFont(ofSize: 24)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
        
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        addSubview(trackImageView)
        addSubview(artistLabel)
        addSubview(albumLabel)
        addSubview(sectionLabel)
        
        trackImageView.topAnchor.constraint(equalTo:self.topAnchor, constant: 10).isActive = true
        trackImageView.centerXAnchor.constraint(equalTo:self.centerXAnchor).isActive = true
        trackImageView.widthAnchor.constraint(equalToConstant:100).isActive = true
        trackImageView.heightAnchor.constraint(equalToConstant:100).isActive = true
        
        artistLabel.topAnchor.constraint(equalTo:self.trackImageView.bottomAnchor, constant: 10).isActive = true
        artistLabel.leadingAnchor.constraint(equalTo:self.leadingAnchor, constant:10).isActive = true
        artistLabel.trailingAnchor.constraint(equalTo:self.trailingAnchor, constant:-10).isActive = true
        
        albumLabel.topAnchor.constraint(equalTo:self.artistLabel.bottomAnchor, constant: 2).isActive = true
        albumLabel.leadingAnchor.constraint(equalTo:self.leadingAnchor, constant:10).isActive = true
        albumLabel.trailingAnchor.constraint(equalTo:self.trailingAnchor, constant:-10).isActive = true
        
        sectionLabel.topAnchor.constraint(equalTo:self.albumLabel.bottomAnchor, constant: 10).isActive = true
        sectionLabel.leadingAnchor.constraint(equalTo:self.leadingAnchor, constant:10).isActive = true
        sectionLabel.trailingAnchor.constraint(equalTo:self.trailingAnchor, constant:-10).isActive = true
        
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
}
