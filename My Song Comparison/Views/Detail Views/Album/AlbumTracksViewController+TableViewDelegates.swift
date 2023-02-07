//
//  AlbumTracksViewController+TableViewDelegates.swift
//  My Song Comparison
//
//  Created by Jarred Davis on 1/23/23.
//

import UIKit
import SwiftUI

extension AlbumTracksViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
        case 0:
            return nil
        case 1:
            return "Tracks"
        default:
            return nil
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 1
        case 1:
            return self.vm?.trackCount ?? 0
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.section {
        case 0:
            return 250
        case 1:
            return 180
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch indexPath.section {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: "albumTracksTableViewHeaderCell", for: indexPath) as! AlbumTracksTableViewHeaderCell
            if let cVM = self.vm {
                cell.album = cVM.album
            }
            return cell
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: "trackDetailTableViewCell", for: indexPath) as! TrackDetailTableViewCell
            if let cVM = self.vm {
                cell.track = cVM.getTrackAndDetailsVM(at: indexPath.row)
            }
            return cell
        default:
            return UITableViewCell()
        }
        
        

    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let cVM = self.vm else { return }
        
        switch indexPath.section {
        case 0:
            let albumTracksChartVM = AlbumTracksChartViewModel(albumTracks: cVM.tracks, trackDetails: cVM.trackDetails)
            let albumTracksChartSwiftUIController = UIHostingController(rootView: AlbumTracksChart(vm:albumTracksChartVM))
            navigationController?.pushViewController(albumTracksChartSwiftUIController, animated: true)
            return
        case 1:
            let trackViewModel = cVM.getTrackAndDetailsVM(at: indexPath.row)
            guard   let track = trackViewModel.track,
                    let trackDetail = trackViewModel.trackDetail else { return }
            
            let trackDetailVC = TrackDetailsViewController()
            trackDetailVC.title = trackViewModel.name
            trackDetailVC.vm = TrackDetailsCollectionViewModel(track: track, trackDetail: trackDetail)
            trackDetailVC.navigationItem.largeTitleDisplayMode = .never
            navigationController?.pushViewController(trackDetailVC, animated: true)
        default:
            return
        }
        
    }
}
