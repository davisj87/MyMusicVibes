//
//  ArtistAlbumViewController+TableViewDelegates.swift
//  My Song Comparison
//
//  Created by Jarred Davis on 1/21/23.
//

import UIKit

extension ArtistAlbumsViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
        case 0:
            return "Albums"
        default:
            return ""
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.vm?.rows.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "artistAlbumsTableViewCell", for: indexPath) as! ArtistAlbumsTableViewCell
        if let cVM = self.vm {
            cell.album = cVM.rows[indexPath.row]
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let cVM = self.vm else { return }
        let albumTracksVC = AlbumTracksViewController()
        albumTracksVC.title = cVM.rows[indexPath.row].name
        albumTracksVC.vm = AlbumTracksViewModel(album: cVM.rows[indexPath.row])//(id: cVM.rows[indexPath.row])
        albumTracksVC.navigationItem.largeTitleDisplayMode = .never
        navigationController?.pushViewController(albumTracksVC, animated: true)

    }
}
