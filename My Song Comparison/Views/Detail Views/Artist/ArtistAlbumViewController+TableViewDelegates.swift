//
//  ArtistAlbumViewController+TableViewDelegates.swift
//  My Song Comparison
//
//  Created by Jarred Davis on 1/21/23.
//

import UIKit

extension ArtistAlbumsViewController: UITableViewDelegate, UITableViewDataSource, UIScrollViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
        case 0:
            return nil
        case 1:
            return "Albums"
        default:
            return nil
        }
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 1
        case 1:
            return self.vm.albumCount
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.section {
        case 0:
            return 280
        case 1:
            return 120
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch indexPath.section {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: "artistAlbumTableViewHeaderCell", for: indexPath) as! ArtistAlbumTableViewHeaderCell
            cell.configure(self.vm.artist)
            return cell
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: "artistAlbumsTableViewCell", for: indexPath) as! ArtistAlbumsTableViewCell
            cell.configure(self.vm.getAlbumVM(at: indexPath.row))
            return cell
        default:
            return UITableViewCell()
        }
        
 
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.section {
        case 0:
            return
        case 1:
            let album = self.vm.getAlbumVM(at: indexPath.row)
            let albumTracksVC = AlbumTracksViewController(viewModel: AlbumTracksViewModel(album: album))
            albumTracksVC.title = "Album"
            albumTracksVC.navigationItem.largeTitleDisplayMode = .never
            navigationController?.pushViewController(albumTracksVC, animated: true)
        default:
            return
        }
    }
    

    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        guard self.vm.albumTotal > self.vm.albumCount else { return }
        
        let position = scrollView.contentOffset.y
        if position > (albumTableView.contentSize.height - 100 - scrollView.frame.size.height) {
            Task{
                do {
                    self.albumTableView.tableFooterView = self.createSpinnerFooter()
                    try await self.vm.getMoreAlbumData()
                    self.albumTableView.reloadData()
                    self.albumTableView.tableFooterView = nil
                } catch {
                    self.albumTableView.tableFooterView = nil
                    print("Error getting more albums")
                }
            }
        }
    }
}
