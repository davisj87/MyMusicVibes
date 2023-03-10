//
//  ViewController.swift
//  My Song Comparison
//
//  Created by Jarred Davis on 12/29/22.
//

import UIKit

final class HomeViewController: UIViewController {
    
    let vm: HomeViewModel = HomeViewModel()
    private let homeTableView: UITableView = UITableView()
    private var loadingTask: Task<Void, Never>?
    
    
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
        
        homeTableView.register(HomeTableViewCell.self, forCellReuseIdentifier: "homeTableViewCell")
        
        homeTableView.translatesAutoresizingMaskIntoConstraints = false
        homeTableView.topAnchor.constraint(equalTo:view.topAnchor).isActive = true
        homeTableView.leftAnchor.constraint(equalTo:view.leftAnchor).isActive = true
        homeTableView.rightAnchor.constraint(equalTo:view.rightAnchor).isActive = true
        homeTableView.bottomAnchor.constraint(equalTo:view.bottomAnchor).isActive = true
    }
    
    func getTopObjects() {
        loadingTask = Task { [weak self] in
            do {
                self?.showSpinner()
                try await self?.vm.loadTopItems()
                self?.homeTableView.reloadData()
            } catch {
                print("Error getting top artists")
            }
            self?.removeSpinner()
        }
    }
    
    deinit {
        loadingTask?.cancel()
    }
    
}

