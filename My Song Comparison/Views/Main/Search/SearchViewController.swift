//
//  SearchViewController.swift
//  My Song Comparison
//
//  Created by Jarred Davis on 1/9/23.
//

import UIKit

class SearchViewController: UIViewController {
    
    let vm: SearchViewModel = SearchViewModel()
    let searchTableView: UITableView = UITableView()
    let activityView = UIActivityIndicatorView(style: .medium)
    let searchController = UISearchController(searchResultsController: nil)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Search"
        self.view.backgroundColor = .systemBackground
        
        self.activityView.center = self.view.center
        self.view.addSubview(activityView)
        
        self.addTableViewWithContraints()
        self.addSearchBar()
        
    }
    
    func addTableViewWithContraints() {
        self.view.addSubview(searchTableView)
        
        searchTableView.delegate = self
        searchTableView.dataSource = self
        searchTableView.separatorStyle = .none
        
        searchTableView.register(SearchTableViewCell.self, forCellReuseIdentifier: "searchTableViewCell")

        
        searchTableView.translatesAutoresizingMaskIntoConstraints = false
        searchTableView.topAnchor.constraint(equalTo:view.topAnchor).isActive = true
        searchTableView.leftAnchor.constraint(equalTo:view.leftAnchor).isActive = true
        searchTableView.rightAnchor.constraint(equalTo:view.rightAnchor).isActive = true
        searchTableView.bottomAnchor.constraint(equalTo:view.bottomAnchor).isActive = true
    }
    
    func addSearchBar() {
        self.searchController.searchBar.delegate = self
        self.searchController.searchBar.placeholder = "Type the genre, album, track, or artist"
        
        searchController.searchBar.scopeButtonTitles = SearchType.allCases.map { $0.rawValue }//["Albums", "Genre", "Artists"]
        
        definesPresentationContext = true
        searchTableView.tableHeaderView = searchController.searchBar
    }
}
