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

class SearchResultsViewController: UIViewController,  UITableViewDelegate, UITableViewDataSource {
    
    weak var delegate: SearchResultsViewControllerDelegate?
    
    private let vm: SearchViewModel = SearchViewModel()
    private let searchTableView: UITableView = UITableView()
    
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
        Task {
            do {
                self.showSpinner()
                try await self.vm.searchMusic(type: scope, query: query)
                self.searchTableView.reloadData()
            } catch {
                print("didn't work")
            }
            self.removeSpinner()
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
        cell.seachCellViewModel = self.vm.searchViewModelCells[indexPath.row]
        return cell

    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.delegate?.didTapSearchResult(result: self.vm.searchViewModelCells[indexPath.row])
    }
    
    
}
