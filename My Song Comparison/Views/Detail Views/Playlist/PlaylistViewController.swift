//
//  PlaylistViewController.swift
//  My Song Comparison
//
//  Created by Jarred Davis on 1/9/23.
//

import UIKit

class PlaylistViewController: UIViewController {
    var vm: PlaylistTracksViewModel?
    private let playlistTableView: UITableView = UITableView()
// This will show list of tracks from a playlist as well as an overview of the playlist
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .systemBackground
        self.addTableViewWithContraints()
        self.getPlaylistTracks()
    }
    
    func addTableViewWithContraints() {
        self.view.addSubview(playlistTableView)
        
        playlistTableView.delegate = self
        playlistTableView.dataSource = self
        playlistTableView.separatorStyle = .none

        playlistTableView.register(TrackDetailTableViewCell.self, forCellReuseIdentifier: "trackDetailTableViewCell")
        
        playlistTableView.translatesAutoresizingMaskIntoConstraints = false
        playlistTableView.topAnchor.constraint(equalTo:view.topAnchor).isActive = true
        playlistTableView.leftAnchor.constraint(equalTo:view.leftAnchor).isActive = true
        playlistTableView.rightAnchor.constraint(equalTo:view.rightAnchor).isActive = true
        playlistTableView.bottomAnchor.constraint(equalTo:view.bottomAnchor).isActive = true
    }

    func getPlaylistTracks() {
        Task {
            do {
                guard let cVM = self.vm else { return }
                try await cVM.getTracks()
                self.playlistTableView.reloadData()
            } catch {
                print("Error getting playlist tracks")
            }
        }
    }
    
}
