//
//  ViewController+Extension.swift
//  My Song Comparison
//
//  Created by Jarred Davis on 2/7/23.
//

import UIKit

fileprivate var spinnerView:UIView?

extension UIViewController {
    
    func showSpinner() {
        spinnerView = UIView(frame: self.view.bounds)
        spinnerView?.backgroundColor = UIColor.gray
        
        guard let spinnerView = spinnerView else { return }
        let spinnerActivityView = UIActivityIndicatorView(style: .large)
        spinnerActivityView.center = spinnerView.center
        spinnerActivityView.startAnimating()
        spinnerView.addSubview(spinnerActivityView)
        self.view.addSubview(spinnerView)
    }
    
    func removeSpinner () {
        spinnerView?.removeFromSuperview()
        spinnerView = nil
    }
    
}
