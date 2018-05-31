//
//  BaseViewController.swift
//  Challenge-AS
//
//  Created by Luiz Henrique Bueno on 5/23/18.
//  Copyright © 2018 NxT. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func showAlert(message: String) {
        let alert = UIAlertController(title: Constants.ALERT.OOPS, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: Constants.ALERT.OK, style: .default, handler: nil))
        self.present(alert, animated: true)
    }
}
