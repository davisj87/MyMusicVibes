//
//  SearchViewController+SearchBar.swift
//  My Song Comparison
//
//  Created by Jarred Davis on 1/27/23.
//

import UIKit

extension SearchViewController: UISearchBarDelegate, UISearchResultsUpdating  {
     
    func updateSearchResults(for searchController: UISearchController) {
        return
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let resultsController = searchController.searchResultsController as? SearchResultsViewController,
              let query = searchBar.text,
                !query.trimmingCharacters(in: .whitespaces).isEmpty else {
                  return
              }
        let currentScope = self.selectedScope()
        resultsController.update(query: query, scope: currentScope)
    }
    
    func selectedScope() -> String {
      guard let scopeButtonTitles = searchController.searchBar.scopeButtonTitles else {
          return SearchType.album.rawValue
      }
      return scopeButtonTitles[searchController.searchBar.selectedScopeButtonIndex]
    }
    
    func searchBar(_ searchBar: UISearchBar, selectedScopeButtonIndexDidChange selectedScope: Int) {
        print("New scope index is now \(selectedScope)")
    }
    
    
}
