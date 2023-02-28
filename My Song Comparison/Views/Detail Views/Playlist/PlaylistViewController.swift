//
//  PlaylistViewController.swift
//  My Song Comparison
//
//  Created by Jarred Davis on 1/9/23.
//

import UIKit

final class PlaylistViewController: UIViewController {
    let vm: PlaylistTracksViewModel
    private let playlistTableView: UITableView = UITableView()
    private var loadingTask: Task<Void, Never>?
// This will show list of tracks from a playlist as well as an overview of the playlist
    
    init(viewModel:PlaylistTracksViewModel) {
        self.vm = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
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
        playlistTableView.register(PlaylistTableViewHeaderCell.self, forCellReuseIdentifier: "playlistTableViewHeaderCell")
        
        playlistTableView.translatesAutoresizingMaskIntoConstraints = false
        playlistTableView.topAnchor.constraint(equalTo:view.topAnchor).isActive = true
        playlistTableView.leftAnchor.constraint(equalTo:view.leftAnchor).isActive = true
        playlistTableView.rightAnchor.constraint(equalTo:view.rightAnchor).isActive = true
        playlistTableView.bottomAnchor.constraint(equalTo:view.bottomAnchor).isActive = true
    }

    func getPlaylistTracks() {
        loadingTask = Task { [weak self] in
            do {
                self?.showSpinner()
                try await self?.vm.getTracks()
                self?.playlistTableView.reloadData()
            } catch {
                print("Error getting playlist tracks")
            }
            self?.removeSpinner()
        }
    }
    
    deinit {
        loadingTask?.cancel()
    }
    
}
