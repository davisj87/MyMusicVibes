//
//  HomeViewController+TableViewDelegates.swift
//  My Song Comparison
//
//  Created by Jarred Davis on 1/16/23.
//

import UIKit

extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.vm.sections.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return self.vm.sections[section].title.rawValue
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.vm.sections[section].homeCells.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "homeTableViewCell", for: indexPath) as! HomeTableViewCell
        cell.configure(self.vm.sections[indexPath.section].homeCells[indexPath.row])
        return cell
   
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let section = self.vm.sections[indexPath.section]
        switch section.title {
        case .artist:
            guard let artist = section.homeCells[indexPath.row] as? ArtistCellViewModel else { return }
            let artistAlbumsVC = ArtistAlbumsViewController(viewModel: ArtistAlbumsViewModel(artist: artist))
            artistAlbumsVC.title = "Artist"
            artistAlbumsVC.navigationItem.largeTitleDisplayMode = .never
            navigationController?.pushViewController(artistAlbumsVC, animated: true)
        case .track:
            guard let track = section.homeCells[indexPath.row] as? TrackCellViewModel else { return }
            let trackVC = TrackDetailsViewController(viewModel: TrackDetailsCollectionViewModel(track: track))
            trackVC.title = "Track"
            trackVC.navigationItem.largeTitleDisplayMode = .never
            navigationController?.pushViewController(trackVC, animated: true)
        case .playlist:
            guard let playlist = section.homeCells[indexPath.row] as? PlaylistCellViewModel else { return }
            let playlistVC = PlaylistViewController(viewModel: PlaylistTracksViewModel(playlist: playlist))
            playlistVC.title = "Playlist"
            playlistVC.navigationItem.largeTitleDisplayMode = .never
            navigationController?.pushViewController(playlistVC, animated: true)
        }
    }
    
}
