//
//  AlamofireNetworking.swift
//  Challenge-AS
//
//  Created by Luiz Henrique Bueno on 5/23/18.
//  Copyright © 2018 NxT. All rights reserved.
//

import Foundation
import Alamofire

class AlamofireNetworking {
    
    // MARK: - Shared Instance
    
    static let sharedInstance: AlamofireNetworking = {
        let instance = AlamofireNetworking()
        return instance
    }()
    
    
    //MARK: Local Variable
    
    var mgr: Alamofire.SessionManager?
    var cookieStorage: HTTPCookieStorage!
    
    private init(){
        self.cookieStorage = HTTPCookieStorage.shared
        self.mgr = self.configureManager()
    }
    
    
    // MARK: Public methods
    
    // Conforms to AbstractRxNetworking
    func doGet<Req: AbstractRequest, Res: AbstractResponse>(
                 requestObject: Req,
                       urlType: Constants.WebService.EndPoint.UrlType =
                                Constants.WebService.EndPoint.UrlType.Unlogged,
                      encoding: ParameterEncoding =
                                URLEncoding.default,
                       success: @escaping (_ responseObject: Res?, _ responseList: [Res]?,  _ allCookies: [HTTPCookie]?, _ allHeader: [AnyHashable: Any]?) -> (),
                       failure: @escaping (ASError?) -> ()) {
        
        self.doRequest (requestObject: requestObject, method: HTTPMethod.get,  urlType: urlType,  encoding: encoding, header: nil,  success: success,  failure: failure)
    }
    
    // Conforms to AbstractRxNetworking
    func doPost<Req: AbstractRequest, Res: AbstractResponse>(requestObject: Req,
                                                             urlType: Constants.WebService.EndPoint.UrlType = Constants.WebService.EndPoint.UrlType.Logged,
                                                             encoding: ParameterEncoding = JSONEncoding.default,
                                                             success: @escaping (_ responseObject: Res?, _ responseList: [Res]?, _ allCookies: [HTTPCookie]?, _ allHeader: [AnyHashable: Any]?) -> (),
                                                             failure: @escaping (ASError?) -> ()) {
        
        return self.doRequest(requestObject: requestObject, method: HTTPMethod.post, urlType: urlType, encoding: encoding, header: nil, success: success, failure: failure)
    }
    
    func doPost<Req: AbstractRequest, Res: AbstractResponse>(requestObject: Req,
                                                             urlType: Constants.WebService.EndPoint.UrlType = Constants.WebService.EndPoint.UrlType.Logged,
                                                             encoding: ParameterEncoding = JSONEncoding.default,
                                                             header: HTTPHeaders?,
                                                             success: @escaping (_ responseObject: Res?, _ responseList: [Res]?, _ allCookies: [HTTPCookie]?, _ allHeader: [AnyHashable: Any]?) -> (),
                                                             failure: @escaping (ASError?) -> ()) {
        
        return self.doRequest(requestObject: requestObject, method: HTTPMethod.post, urlType: urlType, encoding: encoding, header: header, success: success, failure: failure)
    }
    
    
    // MARK: Private methods
    
    // Makes the HTTP request and parses the response
    private func doRequest<Req: AbstractRequest, Res: AbstractResponse>(requestObject: Req,
                                                                        method: HTTPMethod,
                                                                        urlType: Constants.WebService.EndPoint.UrlType,
                                                                        encoding: ParameterEncoding,
                                                                        header: HTTPHeaders?,
                                                                        success: @escaping (_ responseObject: Res?, _ responseList: [Res]?, _ allCookies: [HTTPCookie]?, _ allHeader: [AnyHashable: Any]? ) -> ()?,
                                                                        failure: @escaping (ASError?) -> ()) {
        
        print(requestObject.prettyPrint())
        print(requestObject.toDictionary())
        
        var hostURL: String
        
        if urlType == Constants.WebService.EndPoint.UrlType.Logged {
            hostURL = APISettings.sharedInstance.environment.hostURLLogged
        } else {
            hostURL = APISettings.sharedInstance.environment.hostURLUnlogged
        }
        print(hostURL + requestObject.urlPath())
        
        _ = self.mgr?.request(hostURL + requestObject.urlPath(), method: method, parameters: requestObject.toDictionary(), encoding: encoding, headers: header ?? (makeDefaultHeader() as? HTTPHeaders))
            .responseJSON ( completionHandler: { response in
                
                let logS = String(data: response.data!, encoding: String.Encoding.utf8)
                print(logS as Any)
                
                #if DEBUG
                for h in (response.request?.allHTTPHeaderFields)! {
                    print("Request Header field: \(h)")
                }
                #endif
                
                switch response.result {
                case .success:
                    do {
                        guard let jsonResponse = response.data else {
                            return
                        }
                        
                        var responseObject: Res? = nil
                        var responseList: [Res] = []
                        
                        if let dic = try JSONSerialization.jsonObject(with: jsonResponse, options: []) as? NSDictionary {
                            responseObject = Res.from(dic)
                            
                            if let error = dic["error"] as? Array<NSDictionary>, error.count > 0 {
                                let apiError = ASError(errorCode: error[0]["errorKey"] as? Int ?? 0, errorMessage: error[0]["errorMessage"] as? String ?? "")
                                failure(apiError)
                                return
                            }
                            
                            if let error = dic["errorlist"] as? Array<NSDictionary>, error.count > 0 {
                                
                                let apiError = ASError(errorCode: error[0]["errorKey"] as? Int ?? 0, errorMessage: error[0]["errorMessage"] as? String ?? "")
                                failure(apiError)
                                return
                            }
                            
                            if let status = dic["status"] as? String, status == "Internal Server Error" {
                                let apiError = ASError(errorCode: 0, errorMessage: "")
                                failure(apiError)
                                return
                            }
                            
                            print(responseObject?.prettyPrint() as Any)
                            
                        } else if let array = response.value as? NSArray {
                            for item in array{
                                if let object = item as? NSDictionary {
                                    responseList.append(Res.from(object)!)
                                }
                            }
                        }
                        
                        let cookies = self.extractCookies(response: response.response, request: response.request)
                        let allHeader = response.response?.allHeaderFields
                        
                        success(responseObject, responseList, cookies, allHeader)
                    } catch {
                        print("Error to parse json object")
                    }
                    break
                case .failure:
                    if response.error != nil {
                        
                        let error = response.error! as NSError
                        print(error.localizedDescription)
                        
                        let apiError = ASError(errorCode: error.code, errorMessage: error.localizedDescription)
                        failure(apiError)
                        
                        return
                    }
                    break
                }
            } )
        
        print(request)
    }

    //Configures the Alamofire Session Manager
    private func configureManager() -> Alamofire.SessionManager {
        let cfg = URLSessionConfiguration.default
        cfg.httpCookieStorage = cookieStorage
        cfg.httpShouldSetCookies = true

        let mrg = Alamofire.SessionManager(configuration: cfg)
        mgr?.delegate.taskWillPerformHTTPRedirectionWithCompletion = { session, task, response, request, completion in
            _ = self.extractCookies(response: response, request: request)
            completion(request)
        }
        return mrg
    }
    
    func extractCookies(response: HTTPURLResponse?, request: URLRequest?) -> [HTTPCookie] {
        var cookies: [HTTPCookie] = []
        if let headerFields = response?.allHeaderFields as? [String: String], let url = request?.url
        {
            cookies = HTTPCookie.cookies(withResponseHeaderFields: headerFields, for: url)
            if let oldCookies = self.cookieStorage.cookies {
                for oldCookie in oldCookies {
                    if cookies.first(where: { $0.name == oldCookie.name}) == nil {
                        cookies.append(oldCookie)
                    }
                    
                }
            }
            
            #if DEBUG
            for (_, c) in cookies.enumerated() {
                print("Extracted Cookie: \(c.name) \(c.value) \(c.domain)")
            }
            #endif
            
            self.updateCookiesWithArrayOf(cookies: cookies)
        }
        return cookies
    }
    
    // Manages the cookies for future requests
    func updateCookiesWithArrayOf(cookies: Array<HTTPCookie>) {
        
        for (_, c) in cookies.enumerated() {
            var d = c.domain
            if d.hasPrefix(".") {
                d = d.substring(from: d.index(d.startIndex, offsetBy: 1))
            }
            
            let cookie = HTTPCookie(properties: [
                HTTPCookiePropertyKey.domain: d,
                HTTPCookiePropertyKey.path: c.path,
                HTTPCookiePropertyKey.name: c.name,
                HTTPCookiePropertyKey.expires: c.expiresDate as AnyObject,
                HTTPCookiePropertyKey.value: c.value
                ])!
            
            var updated = false
            if let oldCookies = self.cookieStorage.cookies {
                for (_,oldCookie) in oldCookies.enumerated() {
                    if oldCookie.name.lowercased() == cookie.name.lowercased() {
                        updated = true
                        if cookie.value != oldCookie.value {
                            self.cookieStorage.deleteCookie(oldCookie)
                            self.cookieStorage.setCookie(cookie)
                        }
                    }
                }
            }
            if !updated {
                self.cookieStorage.setCookie(cookie)
            }
        }
        
        #if DEBUG
        if let cookies = self.cookieStorage.cookies {
            for (_, c) in cookies.enumerated() {
                print("CookieStorage: \(c.name):\(c.value)")
            }
        }
        #endif
    }
    
    // Make default header list to request
    private func makeDefaultHeader() -> NSDictionary {
        
        var parameters = Alamofire.SessionManager.defaultHTTPHeaders
        
        if let cookies = HTTPCookieStorage.shared.cookies {
            
            let cookieParameters  = HTTPCookie.requestHeaderFields(with: cookies)
            
            for (key, value) in cookieParameters {
                parameters[key] = value
            }
        }
        
        parameters["Content-Type"] = "application/json; charset=utf-8"
        parameters["Accept"] = "application/json"
        parameters["charset"] = "utf-8"
        
        #if DEBUG
        for (key, value) in parameters {
            print("\(key):\(value)")
        }
        #endif
        
        return parameters as NSDictionary
    }
    
    func clearAllCookies() {
        if let cookies = self.cookieStorage.cookies {
            for (_,c) in cookies.enumerated() {
                self.cookieStorage.deleteCookie(c)
            }
        }
    }
}

//CryptHash
extension AlamofireNetworking {
    
    func getUserAgent() -> String {
        let dictionary = Bundle.main.infoDictionary!
        let versionApp = "AS/\(dictionary["CFBundleShortVersionString"] as! String)"
        let device = UIDevice.current.userInterfaceIdiom == .phone ? "iPhone" : "iPad"
        let deviceVersion = UIDevice.current.systemVersion
        let scale = UIScreen.main.scale
        let userAgente = "\(versionApp)(\(device);iOS \(deviceVersion);Scale/\(scale))"
        return userAgente
    }
    
    func getAppVersion() -> String {
        let dictionary = Bundle.main.infoDictionary!
        let version = "iOS \(dictionary["CFBundleShortVersionString"] as! String)"
        return version
    }
    
    func randomAlphaNumericString(length: Int) -> String {
        let allowedChars = "ABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890MD"
        let allowedCharsCount = UInt32(allowedChars.count)
        var randomString = ""
        for _ in 0..<length {
            let randomNum = Int(arc4random_uniform(allowedCharsCount))
            let randomIndex = allowedChars.index(allowedChars.startIndex, offsetBy: randomNum)
            let newCharacter = allowedChars[randomIndex]
            randomString += String(newCharacter)
        }
        return randomString
    }
    
    func generateSalt() -> String {
        return randomAlphaNumericString(length: 8);
    }
    
    func generateHashKey() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = TimeZone(identifier: "America/Miami")
        dateFormatter.dateFormat = "yyyyMMddHH";
        let dateAndHourString = dateFormatter.string(from: Date());
        let hashKey = String(format:"%@%@", "mangojata", dateAndHourString);
        return hashKey
    }
    
    //TODO:
//    func generateHashParam() -> String {
//        let hashKey = generateHashKey();
//        let hashParam = MD5Crypt.cryptKey(hashKey, usingSalt: generateSalt()).replacingOccurrences(of: "\0", with: "");
//        return hashParam
//    }
}
