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
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        280
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = ArtistAlbumTableViewHeader.init(frame: CGRect.init(x: 0, y: 0, width: tableView.frame.width, height: 280))
        headerView.artist = self.vm?.artist
        return headerView
    }

    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.vm?.albumCount ?? 0
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "artistAlbumsTableViewCell", for: indexPath) as! ArtistAlbumsTableViewCell
        if let cVM = self.vm {
            cell.album = cVM.getAlbumVM(at: indexPath.row)
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let cVM = self.vm else { return }
        let album = cVM.getAlbumVM(at: indexPath.row)
        let albumTracksVC = AlbumTracksViewController()
        albumTracksVC.title = "Album"
        albumTracksVC.vm = AlbumTracksViewModel(album: album)
        albumTracksVC.navigationItem.largeTitleDisplayMode = .never
        navigationController?.pushViewController(albumTracksVC, animated: true)
    }
}
