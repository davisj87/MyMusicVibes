//
//  TrackViewController+CollectionViewDelegates.swift
//  My Song Comparison
//
//  Created by Jarred Davis on 1/17/23.
//

import Foundation
import UIKit


extension TrackDetailsViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return self.vm.trackSectionViewModel.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.vm.trackSectionViewModel[section].attributes.count

    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let myCell = collectionView.dequeueReusableCell(withReuseIdentifier: "trackDetailCell", for: indexPath) as! TrackDetailCollectionViewCell
        let details = self.vm.trackSectionViewModel[indexPath.section].attributes[indexPath.row]
        myCell.trackDetail = details
        return myCell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if kind == UICollectionView.elementKindSectionFooter {
            let footer = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionFooter,
                                                                         withReuseIdentifier: TrackDetailFooterCollectionReusableView.identifier,
                                                                         for: indexPath) as! TrackDetailFooterCollectionReusableView
            footer.configure()
            return footer
        }
        
        if kind == UICollectionView.elementKindSectionHeader && indexPath.section == 0 {
            let header = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader,
                                                                         withReuseIdentifier: TrackCollectionReusableView.identifier,
                                                                         for: indexPath) as! TrackCollectionReusableView
            let track = self.vm.track
            header.configure(track)
            let section = self.vm.trackSectionViewModel[indexPath.section]
            header.configureSection(section)
            return header
        }
        
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader,
                                                                     withReuseIdentifier: TrackDetailHeaderCollectionReusableView.identifier,
                                                                     for: indexPath) as! TrackDetailHeaderCollectionReusableView
        let section = self.vm.trackSectionViewModel[indexPath.section]
        header.configureSection(section)
        return header
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        if section == 0 {
            return CGSize(width: view.frame.size.width,
                          height: 220)
        }
        return CGSize(width: view.frame.size.width,
                      height: 50)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        return CGSize(width: view.frame.size.width,
                      height: 20)
    }
}
