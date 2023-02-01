//
//  AlbumTracksViewController+TableViewDelegates.swift
//  My Song Comparison
//
//  Created by Jarred Davis on 1/23/23.
//

import UIKit

extension AlbumTracksViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        280
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = AlbumTracksTableViewHeader.init(frame: CGRect.init(x: 0, y: 0, width: tableView.frame.width, height: 280))
        headerView.album = self.vm?.album
        return headerView
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.vm?.trackCount ?? 0
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 180
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "trackDetailTableViewCell", for: indexPath) as! TrackDetailTableViewCell
        if let cVM = self.vm {
            cell.track = cVM.getTrackAndDetailsVM(at: indexPath.row)
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let cVM = self.vm else { return }
        
        let trackViewModel = cVM.getTrackAndDetailsVM(at: indexPath.row)
        guard   let track = trackViewModel.track,
                let trackDetail = trackViewModel.trackDetail else { return }
        
        let trackDetailVC = TrackDetailsViewController()
        trackDetailVC.title = trackViewModel.name
        trackDetailVC.vm = TrackDetailsCollectionViewModel(track: track, trackDetail: trackDetail)
        trackDetailVC.navigationItem.largeTitleDisplayMode = .never
        navigationController?.pushViewController(trackDetailVC, animated: true)
    }
}
