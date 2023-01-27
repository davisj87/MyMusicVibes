//
//  SearchViewController+TableViewDelegates.swift
//  My Song Comparison
//
//  Created by Jarred Davis on 1/27/23.
//

import UIKit

extension SearchViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.vm.searchViewModelCells.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = tableView.dequeueReusableCell(withIdentifier: "searchTableViewCell", for: indexPath) as! SearchTableViewCell
        cell.seachCellViewModel = self.vm.searchViewModelCells[indexPath.row]
        return cell

    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        switch indexPath.section {
//        case 0:
//            let artistAlbumsVC = ArtistAlbumsViewController()
//            artistAlbumsVC.title = self.vm.topItems.topArtists[indexPath.row].name
//            artistAlbumsVC.vm = ArtistAlbumsViewModel(artistId: self.vm.topItems.topArtists[indexPath.row].id)
//            artistAlbumsVC.navigationItem.largeTitleDisplayMode = .never
//            navigationController?.pushViewController(artistAlbumsVC, animated: true)
//        case 1:
//            let trackVC = TrackDetailsViewController()
//            trackVC.title = self.vm.topItems.topTracks[indexPath.row].name
//            trackVC.vm = TrackDetailsCollectionViewModel(track: self.vm.topItems.topTracks[indexPath.row])
//            trackVC.navigationItem.largeTitleDisplayMode = .never
//            navigationController?.pushViewController(trackVC, animated: true)
//        case 2:
//            let playlistVC = PlaylistViewController()
//            playlistVC.title = self.vm.topItems.topPlaylists[indexPath.row].name
//            playlistVC.vm = PlaylistTracksViewModel(id: self.vm.topItems.topPlaylists[indexPath.row].id)
//            playlistVC.navigationItem.largeTitleDisplayMode = .never
//            navigationController?.pushViewController(playlistVC, animated: true)
//        default:
//            return
//        }
    }
    
}
