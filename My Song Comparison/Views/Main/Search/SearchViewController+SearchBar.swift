//
//  SearchViewController+SearchBar.swift
//  My Song Comparison
//
//  Created by Jarred Davis on 1/27/23.
//

import UIKit

extension SearchViewController: UISearchBarDelegate {
     
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        let currentScope = self.selectedScope()
        if let cSearchText = searchBar.text {
            Task {
                do {
                    self.activityView.startAnimating()
                    try await self.vm.searchMusic(type: currentScope, query: cSearchText)
                    self.activityView.stopAnimating()
                    self.searchTableView.reloadData()
                } catch {
                    print("didn't work")
                }
            }
        } else {}
    }
    
//    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
//        if let cSearchText = searchBar.text {
//            Task {
//                do {
////                    self.activityView.startAnimating()
////                    try await self.vm
//                    self.searchTableView.reloadData()
////                    self.activityView.stopAnimating()
//                } catch {
//                    print("didn't work")
//                }
//            }
//        } else {}
//    }
    
    func selectedScope() -> String {
      guard let scopeButtonTitles = searchController.searchBar.scopeButtonTitles else {
          return SearchType.album.rawValue
      }
      return scopeButtonTitles[searchController.searchBar.selectedScopeButtonIndex]
    }
    
//    func searchBar(_ searchBar: UISearchBar, selectedScopeButtonIndexDidChange selectedScope: Int) {
//        print("New scope index is now \(selectedScope)")
//    }
    
    
}
