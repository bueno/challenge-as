//
//  Application+Navigation.swift
//  Challenge-AS
//
//  Created by Luiz Henrique Bueno on 5/28/18.
//  Copyright © 2018 NxT. All rights reserved.
//

import UIKit

// UIApplication extesion providing smart access to default properties
extension UIApplication {
    
    //It returns the default application window if it exists
    func getWindow() -> UIWindow? {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return nil
        }
        
        guard let window = appDelegate.window else {
            return nil
        }
        
        return window
    }
}
