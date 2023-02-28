//
//  AlbumTracksViewController.swift
//  My Song Comparison
//
//  Created by Jarred Davis on 1/23/23.
//

import UIKit

final class AlbumTracksViewController: UIViewController {
    
    let vm: AlbumTracksViewModel
    private let albumTracksTableView: UITableView = UITableView()
    private var loadingTask: Task<Void, Never>?
    
    init(viewModel:AlbumTracksViewModel) {
        self.vm = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
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
        loadingTask = Task { [weak self] in
            do {
                self?.showSpinner()
                try await self?.vm.getTracksData()
                self?.albumTracksTableView.reloadData()
            } catch {
                print("Error getting album tracks")
            }
            self?.removeSpinner()
        }
    }
    
    deinit {
        loadingTask?.cancel()
    }

}
