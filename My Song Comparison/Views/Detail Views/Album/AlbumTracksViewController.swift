//
//  AlbumTracksViewController.swift
//  My Song Comparison
//
//  Created by Jarred Davis on 1/23/23.
//

import UIKit

class AlbumTracksViewController: UIViewController {
    
    //VM will be initalized from previous viewcontroller
    var vm: AlbumTracksViewModel?
    
    private let albumTracksTableView: UITableView = UITableView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        self.addTableViewWithContraints()
        self.getAlbumTracks()
    }
    
    func addTableViewWithContraints() {
        self.view.addSubview(albumTracksTableView)
        
        albumTracksTableView.delegate = self
        albumTracksTableView.dataSource = self
        albumTracksTableView.separatorStyle = .none

        albumTracksTableView.register(TrackDetailTableViewCell.self, forCellReuseIdentifier: "trackDetailTableViewCell")
        albumTracksTableView.register(AlbumTracksTableViewHeaderCell.self, forCellReuseIdentifier: "albumTracksTableViewHeaderCell")
        
        albumTracksTableView.translatesAutoresizingMaskIntoConstraints = false
        albumTracksTableView.topAnchor.constraint(equalTo:view.topAnchor).isActive = true
        albumTracksTableView.leftAnchor.constraint(equalTo:view.leftAnchor).isActive = true
        albumTracksTableView.rightAnchor.constraint(equalTo:view.rightAnchor).isActive = true
        albumTracksTableView.bottomAnchor.constraint(equalTo:view.bottomAnchor).isActive = true
    }

    func getAlbumTracks() {
        Task {
            do {
                guard let cVM = self.vm else { return }
                try await cVM.getAlbumTracks()
                self.albumTracksTableView.reloadData()
            } catch {
                print("Error getting playlist tracks")
            }
        }
    }

}
