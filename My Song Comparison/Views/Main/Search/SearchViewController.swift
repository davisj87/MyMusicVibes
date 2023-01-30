//
//  SearchViewController.swift
//  My Song Comparison
//
//  Created by Jarred Davis on 1/9/23.
//

import UIKit

class SearchViewController: UIViewController {
    
    
   
    let activityView = UIActivityIndicatorView(style: .medium)
    
    let searchController: UISearchController = {
        let results = SearchResultsViewController()
        results.view.backgroundColor = .red
        let vc = UISearchController(searchResultsController: results)
        vc.searchBar.placeholder = "Search for Songs, Artists, Albums, or Genre"
        vc.searchBar.searchBarStyle = .minimal
        vc.searchBar.scopeButtonTitles = SearchType.allCases.map { $0.rawValue }
        vc.definesPresentationContext = true
        return vc
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Search"
        self.view.backgroundColor = .systemBackground
        self.navigationItem.searchController = searchController
        
        self.activityView.center = self.view.center
        self.view.addSubview(activityView)
        self.searchController.searchResultsUpdater = self
        self.searchController.searchBar.delegate = self
        
        definesPresentationContext = true
        
    }
    
    

    
}
