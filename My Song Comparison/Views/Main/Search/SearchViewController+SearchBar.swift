//
//  SearchViewController+SearchBar.swift
//  My Song Comparison
//
//  Created by Jarred Davis on 1/27/23.
//

import UIKit

extension SearchViewController: UISearchBarDelegate, UISearchResultsUpdating  {
     
    func updateSearchResults(for searchController: UISearchController) {}
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let resultsController = searchController.searchResultsController as? SearchResultsViewController,
              let query = searchBar.text,
                !query.trimmingCharacters(in: .whitespaces).isEmpty else {
                  return
              }
        resultsController.delegate = self
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

extension SearchViewController: SearchResultsViewControllerDelegate {
    func didTapSearchResult(result: ItemOverviewCellViewModelProtocol) {
        guard let filter = SearchType(rawValue: self.selectedScope()) else { return }
        switch filter {
        case .album:
            let artistAlbumsVC = ArtistAlbumsViewController()
            artistAlbumsVC.title = result.primaryText
            artistAlbumsVC.vm = ArtistAlbumsViewModel(artistId: result.id)
            artistAlbumsVC.navigationItem.largeTitleDisplayMode = .never
            navigationController?.pushViewController(artistAlbumsVC, animated: true)
        case .artist:
            let artistAlbumsVC = ArtistAlbumsViewController()
            artistAlbumsVC.title = result.primaryText
            artistAlbumsVC.vm = ArtistAlbumsViewModel(artistId: result.id)
            artistAlbumsVC.navigationItem.largeTitleDisplayMode = .never
            navigationController?.pushViewController(artistAlbumsVC, animated: true)
        case .track:
            guard let track = result as? TrackCellViewModel else { return }
            let trackVC = TrackDetailsViewController()
            trackVC.title = result.primaryText
            trackVC.vm = TrackDetailsCollectionViewModel(track: track)
            trackVC.navigationItem.largeTitleDisplayMode = .never
            navigationController?.pushViewController(trackVC, animated: true)
        case .playlist:
            let playlistVC = PlaylistViewController()
            playlistVC.title = result.primaryText
            playlistVC.vm = PlaylistTracksViewModel(id: result.id)
            playlistVC.navigationItem.largeTitleDisplayMode = .never
            navigationController?.pushViewController(playlistVC, animated: true)
        }
    }
}
