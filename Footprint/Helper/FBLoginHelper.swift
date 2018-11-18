//
//  FBLoginHelper.swift
//  Footprint
//
//  Created by Abhinay Maurya on 10/12/16.
//  Copyright © 2016 ONS. All rights reserved.
//

import Foundation
import FacebookCore
import FacebookLogin


typealias FBLoginCompletionHandler = (_ success:Bool, _ responseCode:Int, _ message:String, _ guid:String?, _ mailId:String?) -> ()

final class FBLoginHelper
{
    //Login
    static func login(completionHandler:@escaping FBLoginCompletionHandler)
    {
        if AccessToken.current != nil{
            FBLoginHelper.getUserEmail(completionHandler: completionHandler)
        }
        else{
            let loginManager = LoginManager()
            let permissions = [ReadPermission.custom("public_profile"),ReadPermission.custom("email")]
            
            loginManager.logIn(readPermissions: permissions, viewController: nil, completion: { (loginResult) in
                
                switch loginResult
                {
                case .failed(let error):
                    completionHandler(false, -1, error.localizedDescription, nil, nil)
                case .cancelled:
                    completionHandler(false, -1, "User cancelled login.", nil, nil)
                case .success( _, _, _):
                    FBLoginHelper.getUserEmail(completionHandler: completionHandler)
                }
            })
        }
    }
    
    //Access User Info
    fileprivate static func getUserEmail (completionHandler:@escaping FBLoginCompletionHandler)
    {
        let connection = GraphRequestConnection()
        var graphRequest = GraphRequest(graphPath: "/me")
        graphRequest.parameters = ["fields": "email, name"]
        
        connection.add(graphRequest) { httpResponse, result in
            switch result
            {
                case .success(let response):
                    
                    if let record = response.dictionaryValue
                    {
                       let email = record["email"] as! String
//                        let fName = record["name"] as! String
//                        let fbid = "\(record ["id"]!)"
                        
                        LoginPageHelper.loginWithFB(userDict: ["email":email], complitionHandler: { (status, responseCode, message, guid, mailId) in
                            completionHandler(status, responseCode, message, guid, mailId)
                        })
                    }else{
                        completionHandler(false, -1, "Failed", nil, nil)
                    }
                
                case .failed( _):
                    completionHandler(false, -1, "Failed", nil, nil)
            }
        }
        connection.start()
    }
    
    //LogOut
    static func logout()
    {
        let loginManager = LoginManager()
        loginManager.logOut()
    }
}




