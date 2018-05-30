//
//  APISettings.swift
//  Challenge-AS
//
//  Created by Luiz Henrique Bueno on 5/23/18.
//  Copyright © 2018 NxT. All rights reserved.
//

import UIKit

class APISettings: NSObject {
    
    static let sharedInstance = APISettings()
    
    var environment: APIEnvironments!
    var chosenEnvironment: String!
    
    override init() {
        super.init()
        self.loadItems()
    }
    
    func loadItems() {
        self.chosenEnvironment = self.getAPISettingsItem(item: "chosenEnvironment") as! String
        self.environment = self.getCurrentEnviroment()
    }
    
    func getAPISettingsItem(item :String) -> AnyObject
    {
        let filePath = Bundle.main.path(forResource: "APISettings", ofType: "plist")!
        let stylesheet : NSDictionary! = NSDictionary(contentsOfFile:filePath)
        
        return stylesheet.object(forKey: item)! as AnyObject
    }
    
    func getCurrentEnviroment() -> APIEnvironments {
        let envs = self.getAPISettingsItem(item: "environments") as! NSArray
        var currentEnvironment: APIEnvironments?
        for env in envs {
            let environment = APIEnvironments()
            
            if let envDictionary = env as? NSDictionary {
                environment.name = envDictionary.object(forKey:"name") as! String
                
                if (environment.name != self.chosenEnvironment){
                    continue
                }
                
                environment.name = envDictionary.object(forKey:"name") as? String ?? ""
                environment.APIKey = envDictionary.object(forKey:"APIKey") as? String ?? ""
                environment.scheme = envDictionary.object(forKey:"scheme") as? String ?? ""
                environment.host = envDictionary.object(forKey:"host") as? String ?? ""
                environment.path = envDictionary.object(forKey:"path") as? String ?? ""
                currentEnvironment = environment
            }
            break
        }
        
        return currentEnvironment!
    }
}
