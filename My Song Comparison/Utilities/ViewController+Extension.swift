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
    
    
    func createSpinnerFooter() -> UIView {
        let footerView = UIView(frame: CGRect(x: 0, y: 0, width: view.frame.size.width, height: 100))
        let spinner = UIActivityIndicatorView()
        spinner.center = footerView.center
        footerView.addSubview(spinner)
        spinner.startAnimating()
        return footerView
    }
    
    
}
