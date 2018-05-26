//
//  WatchDetailViewController.swift
//  Challenge-AS
//
//  Created by Luiz Henrique Bueno on 5/24/18.
//  Copyright © 2018 NxT. All rights reserved.
//

import UIKit

class WatchDetailViewController: BaseViewController {
    
    var symbol: Symbol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = symbol?.id
        self.tabBarController?.tabBar.isHidden = true
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        self.tabBarController?.tabBar.isHidden = false
    }
}
