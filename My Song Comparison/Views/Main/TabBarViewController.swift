//
//  TabBarViewController.swift
//  My Song Comparison
//
//  Created by Jarred Davis on 1/9/23.
//

import UIKit

final class TabBarViewController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tabBar.backgroundColor = .systemGray
        
        let homeVC = HomeViewController()
        let searchVC = SearchViewController()
        let libraryVC = LibraryViewController()
        
        homeVC.navigationItem.largeTitleDisplayMode = .always
        searchVC.navigationItem.largeTitleDisplayMode = .always
        libraryVC.navigationItem.largeTitleDisplayMode = .always
        
        let homeNav = UINavigationController(rootViewController: homeVC)
        let searchNav = UINavigationController(rootViewController: searchVC)
        let libraryNav = UINavigationController(rootViewController: libraryVC)
        
        homeNav.navigationBar.tintColor = .label
        searchNav.navigationBar.tintColor = .label
        libraryNav.navigationBar.tintColor = .label
        
        homeNav.tabBarItem = UITabBarItem(title: "Home", image: UIImage(systemName: "house"), tag: 1)
        searchNav.tabBarItem = UITabBarItem(title: "Search", image: UIImage(systemName: "magnifyingglass"), tag: 1)
        libraryNav.tabBarItem = UITabBarItem(title: "Lirbary", image: UIImage(systemName: "music.note.list"), tag: 1)
        
        homeNav.navigationBar.prefersLargeTitles = true
        searchNav.navigationBar.prefersLargeTitles = true
        libraryNav.navigationBar.prefersLargeTitles = true
        
        self.setViewControllers([homeNav, searchNav, libraryNav], animated: false)
        
    }

}
