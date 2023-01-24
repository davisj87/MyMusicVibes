//
//  ViewController.swift
//  My Song Comparison
//
//  Created by Jarred Davis on 12/29/22.
//

import UIKit

class HomeViewController: UIViewController {
    
    let vm: HomeViewModel = HomeViewModel()
    private let homeTableView: UITableView = UITableView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Home"
        self.view.backgroundColor = .systemBackground
        self.addTableViewWithContraints()
        
        self.getTopObjects()
    }
    
    func addTableViewWithContraints() {
        self.view.addSubview(homeTableView)
        
        homeTableView.delegate = self
        homeTableView.dataSource = self
        homeTableView.separatorStyle = .none
        
        homeTableView.register(TopArtistTableViewCell.self, forCellReuseIdentifier: "artistCell")
        homeTableView.register(TopTrackTableViewCell.self, forCellReuseIdentifier: "trackCell")
        homeTableView.register(TopPlaylistTableViewCell.self, forCellReuseIdentifier: "playlistCell")
        
        homeTableView.translatesAutoresizingMaskIntoConstraints = false
        homeTableView.topAnchor.constraint(equalTo:view.topAnchor).isActive = true
        homeTableView.leftAnchor.constraint(equalTo:view.leftAnchor).isActive = true
        homeTableView.rightAnchor.constraint(equalTo:view.rightAnchor).isActive = true
        homeTableView.bottomAnchor.constraint(equalTo:view.bottomAnchor).isActive = true
    }
    
    func getTopObjects() {
        Task {
            do {
                try await self.vm.loadTopItems()
                self.homeTableView.reloadData()
            } catch {
                print("Error getting top artists")
            }
        }
    }


}

