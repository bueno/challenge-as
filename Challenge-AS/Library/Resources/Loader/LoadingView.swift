//
//  LoadingView.swift
//  Challenge-AS
//
//  Created by Luiz Henrique Bueno on 5/28/18.
//  Copyright © 2018 NxT. All rights reserved.
//

import UIKit

// A default class for loading views
class LoadingView {
    
    
    // MARK: Static variable
    
    static let shared: LoadingView = LoadingView()
    
    
    // MARK: Internal variables
    
    private let loadingView: UIView
    var spinnerView : SpinnerView!

    
    // MARK: Initializers
    
    private init() {
        self.loadingView = UINib(nibName: "LoadingView", bundle: nil).instantiate(withOwner: nil, options: nil)[0] as! UIView
        
        for v1 in self.loadingView.subviews
        {
            for v2 in v1.subviews
            {
                if v2 is SpinnerView
                {
                    spinnerView = v2 as! SpinnerView
                    if spinnerView.isAnimating {
                        spinnerView.stopAnimating()
                    } else {
                        spinnerView.startAnimating()
                    }
                }
            }
        }
    }
    
    
    // MARK: Public Methods
    
    func showLoading() {
        self.loadingView.frame = UIScreen.main.bounds
        
        if let window = UIApplication.shared.getWindow(), !window.subviews.contains(self.loadingView) {
            window.addSubview(self.loadingView)
            
            if let vl = self.spinnerView
            {
                vl.startAnimating()
            }
        }
    }
    
    func dismissLoading() {
        self.loadingView.removeFromSuperview()
        if let vl = self.spinnerView
        {
            vl.stopAnimating()
        }
    }
    
}
