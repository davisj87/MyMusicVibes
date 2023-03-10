//
//  SearchResultsViewController.swift
//  My Song Comparison
//
//  Created by Jarred Davis on 1/30/23.
//

import UIKit

protocol SearchResultsViewControllerDelegate: AnyObject {
    func didTapSearchResult(result:ItemOverviewCellViewModelProtocol)
}

final class SearchResultsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UIScrollViewDelegate {
    
    weak var delegate: SearchResultsViewControllerDelegate?
    
    private let vm: SearchViewModel = SearchViewModel()
    private let searchTableView: UITableView = UITableView()
    private var imageLoader = ImageLoader()
    private var loadingTask: Task<Void, Never>?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .systemBackground
        self.addTableViewWithContraints()
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

    func update(query:String, scope:String) {
        guard !self.vm.isSearching else { return }
        self.imageLoader = ImageLoader()
        loadingTask = Task { [weak self] in
            do {
                self?.showSpinner()
                try await self?.vm.searchMusic(type: scope, query: query)
                self?.searchTableView.reloadData()
            } catch {
                print("didn't work")
            }
            self?.removeSpinner()
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.vm.searchViewModelCells.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
        let cell = tableView.dequeueReusableCell(withIdentifier: "searchTableViewCell", for: indexPath) as! SearchTableViewCell
        cell.configure(self.vm.searchViewModelCells[indexPath.row])
        let token = imageLoader.loadImage(self.vm.searchViewModelCells[indexPath.row].imageUrl) { result in
          do {
            let image = try result.get()
            DispatchQueue.main.async {
              cell.pictureView.image = image
            }
          } catch {
            print(error)
          }
        }
        cell.onReuse = {
          if let token = token {
            self.imageLoader.cancelLoad(token)
          }
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.delegate?.didTapSearchResult(result: self.vm.searchViewModelCells[indexPath.row])
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {

        guard !self.vm.isSearching || self.vm.currentSearchScope != .all  else { return }

        guard self.vm.currentScopeTotal > self.vm.searchViewModelCells.count else { return }

        let position = scrollView.contentOffset.y
        if position > (searchTableView.contentSize.height - 100 - scrollView.frame.size.height) {
            loadingTask = Task { [weak self] in
                do {
                    self?.searchTableView.tableFooterView = createSpinnerFooter()
                    try await self?.vm.searchMoreMusic()
                    self?.searchTableView.reloadData()
                    self?.searchTableView.tableFooterView = nil
                } catch {
                    self?.searchTableView.tableFooterView = nil
                    print("Error getting more albums")
                }
            }
        }
    }
    
    deinit {
        loadingTask?.cancel()
    }
}
