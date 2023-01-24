//
//  TrackViewController.swift
//  My Song Comparison
//
//  Created by Jarred Davis on 1/9/23.
//

import UIKit

class TrackViewController: UIViewController {
    var vm: TrackViewModel?
    private var trackCollectionView: UICollectionView?
    
//This will have all the track details. Thinkgs Like sogn Mood, Properties, Context, Etc.
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .systemBackground
        self.addCollectionViewWithContraints()
        self.getTrack()
    }
    
    func addCollectionViewWithContraints() {

        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.sectionInset = UIEdgeInsets(top: 20,
                                           left: 15,
                                           bottom: 10,
                                           right: 15)
        
        layout.itemSize = CGSize(width: (self.view.frame.width/2) - 22,
                                 height: 100)
       
        trackCollectionView = UICollectionView(frame: self.view.frame,
                                               collectionViewLayout: layout)
        
        trackCollectionView?.register(TrackDetailCollectionViewCell.self,
                                      forCellWithReuseIdentifier: "trackDetailCell")
        
        trackCollectionView?.register(TrackCollectionReusableView.self,
                                      forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
                                      withReuseIdentifier: TrackCollectionReusableView.identifier)
        
        trackCollectionView?.register(TrackDetailHeaderCollectionReusableView.self,
                                      forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
                                      withReuseIdentifier: TrackDetailHeaderCollectionReusableView.identifier)
        
        trackCollectionView?.register(TrackDetailFooterCollectionReusableView.self,
                                      forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter,
                                      withReuseIdentifier: TrackDetailFooterCollectionReusableView.identifier)
        
        trackCollectionView?.backgroundColor = UIColor.white
       
        trackCollectionView?.delegate = self
        trackCollectionView?.dataSource = self
        
        guard let collectionView = trackCollectionView else { return }
        
        self.view.addSubview(collectionView)

        trackCollectionView?.translatesAutoresizingMaskIntoConstraints = false
        trackCollectionView?.topAnchor.constraint(equalTo:view.topAnchor).isActive = true
        trackCollectionView?.leftAnchor.constraint(equalTo:view.leftAnchor).isActive = true
        trackCollectionView?.rightAnchor.constraint(equalTo:view.rightAnchor).isActive = true
        trackCollectionView?.bottomAnchor.constraint(equalTo:view.bottomAnchor).isActive = true
    }
    
    func getTrack() {
        Task {
            do {
                guard let cVM = self.vm else { return }
                try await cVM.getTrack()
                self.trackCollectionView?.reloadData()
            } catch {
                print("Error getting track details")
            }
        }
    }

}
