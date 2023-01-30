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
        return self.vm.sections[section].title
//        switch section {
//        case 0:
//            return "Top Artists"
//        case 1:
//            return "Top Tracks"
//        case 2:
//            return "Your Playlists"
//        default:
//            return ""
//        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.vm.sections[section].homeCells.count
//        switch section {
//        case 0:
//            return self.vm.topItems.topArtists.isEmpty ? 0 : self.vm.topItems.topArtists.count
//        case 1:
//            return self.vm.topItems.topTracks.isEmpty ? 0 : self.vm.topItems.topTracks.count
//        case 2:
//            return self.vm.topItems.topPlaylists.isEmpty ? 0 : self.vm.topItems.topPlaylists.count
//        default:
//            return 0
//        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "homeTableViewCell", for: indexPath) as! HomeTableViewCell
        cell.homeCellViewModel = self.vm.sections[indexPath.section].homeCells[indexPath.row]
        return cell
        
//        switch indexPath.section {
//        case 0:
//            let cell = tableView.dequeueReusableCell(withIdentifier: "artistCell", for: indexPath) as! TopArtistTableViewCell
//            cell.artist = self.vm.topItems.topArtists[indexPath.row]
//            return cell
//        case 1:
//            let cell = tableView.dequeueReusableCell(withIdentifier: "trackCell", for: indexPath) as! TopTrackTableViewCell
//            cell.track = self.vm.topItems.topTracks[indexPath.row]
//            return cell
//        case 2:
//            let cell = tableView.dequeueReusableCell(withIdentifier: "playlistCell", for: indexPath) as! TopPlaylistTableViewCell
//            cell.playlist = self.vm.topItems.topPlaylists[indexPath.row]
//            return cell
//        default:
//            return UITableViewCell()
//        }

        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let section = self.vm.sections[indexPath.section]
        switch section.title {
        case "Artist":
            let artistAlbumsVC = ArtistAlbumsViewController()
            artistAlbumsVC.title = section.title//self.vm.topItems.topArtists[indexPath.row].name
            artistAlbumsVC.vm = ArtistAlbumsViewModel(artistId: section.homeCells[indexPath.row].id)
            artistAlbumsVC.navigationItem.largeTitleDisplayMode = .never
            navigationController?.pushViewController(artistAlbumsVC, animated: true)
        case "Track":
            let trackVC = TrackDetailsViewController()
            trackVC.title = section.title
            //trackVC.vm = TrackDetailsCollectionViewModel(track: self.vm.topItems.topTracks[indexPath.row])
            trackVC.navigationItem.largeTitleDisplayMode = .never
            navigationController?.pushViewController(trackVC, animated: true)
        case "Playlist":
            let playlistVC = PlaylistViewController()
            playlistVC.title = section.title
            playlistVC.vm = PlaylistTracksViewModel(id: section.homeCells[indexPath.row].id)
            playlistVC.navigationItem.largeTitleDisplayMode = .never
            navigationController?.pushViewController(playlistVC, animated: true)
        default:
            return
        }
    }
    
}
