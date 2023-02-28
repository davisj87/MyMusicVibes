//
//  PlaylistViewController+TableViewDelegates.swift
//  My Song Comparison
//
//  Created by Jarred Davis on 1/20/23.
//

import UIKit
import SwiftUI

extension PlaylistViewController: UITableViewDelegate, UITableViewDataSource {
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
            return self.vm.trackCount
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.section {
        case 0:
            return 280
        case 1:
            return 180
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch indexPath.section {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: "playlistTableViewHeaderCell", for: indexPath) as! PlaylistTableViewHeaderCell
            cell.configure(self.vm.playlist)
            return cell
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: "trackDetailTableViewCell", for: indexPath) as! TrackDetailTableViewCell
            cell.configure(self.vm.getTrackAndDetailsVM(at: indexPath.row))
            return cell
        default:
            return UITableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.section {
        case 0:
            let playlistTracksChartVM = PlaylistTracksChartViewModel(playlistTracks: self.vm.playlistTracks, trackDetails: self.vm.trackDetailsArr)
            let playlistTracksChartSwiftUIController = UIHostingController(rootView: PlaylistTracksChart(vm:playlistTracksChartVM))
            navigationController?.pushViewController(playlistTracksChartSwiftUIController, animated: true)
            return
        case 1:
            let trackViewModel = self.vm.getTrackAndDetailsVM(at: indexPath.row)
            guard   let track = trackViewModel.track,
                    let trackDetail = trackViewModel.trackDetail else { return }
            
            let trackDetailVC = TrackDetailsViewController(viewModel: TrackDetailsCollectionViewModel(track: track, trackDetail: trackDetail))
            trackDetailVC.title = trackViewModel.name
            trackDetailVC.navigationItem.largeTitleDisplayMode = .never
            navigationController?.pushViewController(trackDetailVC, animated: true)
        default:
            return
        }
    }
}
