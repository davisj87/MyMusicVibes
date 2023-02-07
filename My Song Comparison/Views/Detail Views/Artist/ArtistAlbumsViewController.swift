//
//  AlbumViewController.swift
//  My Song Comparison
//
//  Created by Jarred Davis on 1/9/23.
//

import UIKit

class ArtistAlbumsViewController: UIViewController {
    
    var vm: ArtistAlbumsViewModel?
    private let albumTableView: UITableView = UITableView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .systemBackground
        self.addTableViewWithContraints()
        self.getAlbums()
    }
    
    func addTableViewWithContraints() {
        self.view.addSubview(albumTableView)
        
        albumTableView.delegate = self
        albumTableView.dataSource = self
        albumTableView.separatorStyle = .none

        albumTableView.register(ArtistAlbumsTableViewCell.self, forCellReuseIdentifier: "artistAlbumsTableViewCell")
        albumTableView.register(ArtistAlbumTableViewHeaderCell.self, forCellReuseIdentifier: "artistAlbumTableViewHeaderCell")
        
        albumTableView.translatesAutoresizingMaskIntoConstraints = false
        albumTableView.topAnchor.constraint(equalTo:view.topAnchor).isActive = true
        albumTableView.leftAnchor.constraint(equalTo:view.leftAnchor).isActive = true
        albumTableView.rightAnchor.constraint(equalTo:view.rightAnchor).isActive = true
        albumTableView.bottomAnchor.constraint(equalTo:view.bottomAnchor).isActive = true
    }

    func getAlbums() {
        Task {
            do {
                guard let cVM = self.vm else { return }
                try await cVM.getAlbumsFromArtist()
                self.albumTableView.reloadData()
            } catch {
                print("Error getting playlist tracks")
            }
        }
    }
    

}
