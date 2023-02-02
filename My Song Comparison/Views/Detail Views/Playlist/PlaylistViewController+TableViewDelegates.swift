//
//  PlaylistViewController+TableViewDelegates.swift
//  My Song Comparison
//
//  Created by Jarred Davis on 1/20/23.
//

import UIKit

extension PlaylistViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
//    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
//        250
//    }
//
//    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
//        let headerView = PlaylistTableViewHeader.init(frame: CGRect.init(x: 0, y: 0, width: tableView.frame.width, height: 250))
//        headerView.playlist = self.vm?.playlist
//        return headerView
//    }
    
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
            let cell = tableView.dequeueReusableCell(withIdentifier: "playlistTableViewHeaderCell", for: indexPath) as! PlaylistTableViewHeaderCell
            if let cVM = self.vm {
                cell.playlist = cVM.playlist
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
