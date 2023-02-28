//
//  AlbumViewController.swift
//  My Song Comparison
//
//  Created by Jarred Davis on 1/9/23.
//

import UIKit

final class ArtistAlbumsViewController: UIViewController {
    
    let vm: ArtistAlbumsViewModel
    let albumTableView: UITableView = UITableView()
    private var loadingTask: Task<Void, Never>?
    
    init(viewModel:ArtistAlbumsViewModel) {
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
        loadingTask = Task { [weak self] in
            do {
                self?.showSpinner()
                try await self?.vm.getAlbumData()
                self?.albumTableView.reloadData()
            } catch {
                print("Error getting albums")
            }
            self?.removeSpinner()
        }
    }

    deinit {
        loadingTask?.cancel()
    }
    
}
