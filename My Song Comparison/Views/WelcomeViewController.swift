//
//  WelcomeViewController.swift
//  My Song Comparison
//
//  Created by Jarred Davis on 1/9/23.
//

import UIKit

class WelcomeViewController: UIViewController {

    private let signInButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .white
        button.setTitle("Sign In With Spotify", for: .normal)
        button.setTitleColor(.blue, for: .normal)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "MyMusicVibes"
        self.view.backgroundColor = .systemGreen
        self.view.addSubview(self.signInButton)
        self.signInButton.addTarget(self, action: #selector(didTapSignIn), for: .touchUpInside)
        
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        self.signInButton.frame = CGRect(x: 20,
                                         y: self.view.frame.height - 50 - self.view.safeAreaInsets.bottom,
                                         width: self.view.frame.width - 40,
                                         height: 50)
    }
    
    @objc func didTapSignIn() {
        let authVC = AuthViewController()
        authVC.completionHandler = {[weak self] success in
            self?.handleSignIn(success: success)
        }
        authVC.navigationItem.largeTitleDisplayMode = .never
        self.navigationController?.present(authVC, animated: true, completion: nil)
    }
    
    private func handleSignIn(success:Bool) {
        guard success else {
            let alertView = UIAlertController(title: "Oh No!", message: "There was an issue with your signin", preferredStyle: .alert)
            let dismissAction = UIAlertAction(title: "Dismiss", style: .cancel, handler: nil)
            alertView.addAction(dismissAction)
            present(alertView, animated: true)
            return
        }
        
        let mainTabBarVC = TabBarViewController()
        mainTabBarVC.modalPresentationStyle = .fullScreen
        self.present(mainTabBarVC, animated: true)
    }
}
