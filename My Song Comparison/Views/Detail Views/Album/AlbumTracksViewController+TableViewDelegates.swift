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
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
        case 0:
            return "Tracks"
        default:
            return ""
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.vm?.rows.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 180
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "trackDetailTableViewCell", for: indexPath) as! TrackDetailTableViewCell
        if let cVM = self.vm {
            cell.track = cVM.rows[indexPath.row].track
            cell.trackDetailShort = cVM.rows[indexPath.row].detailsShort
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let cVM = self.vm else { return }
        let trackVC = TrackViewController()
        trackVC.title = cVM.rows[indexPath.row].track.name
        trackVC.vm = TrackViewModel(track: cVM.rows[indexPath.row].track, trackDetail: cVM.rows[indexPath.row].details)
        trackVC.navigationItem.largeTitleDisplayMode = .never
        navigationController?.pushViewController(trackVC, animated: true)
    }
}
