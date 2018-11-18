//
//  LoginPageHelper.swift
//  Footprint
//
//  Created by Abhinay Maurya on 17/10/16.
//  Copyright © 2016 ONS. All rights reserved.
//

import Foundation

final class LoginPageHelper
{
    let sharedInstance = LoginPageHelper()
}


//MARK:- API Call
extension LoginPageHelper
{
    typealias LoginRequestCompletionHandler = (_ success:Bool, _ message:String) -> ()
    typealias RegistrationRequestCompletionHandler = (_ success:Bool, _ code:Int, _ message:String, _ guid:String?) -> ()
    typealias FBRegistrationRequestCompletionHandler = (_ success:Bool, _ code:Int, _ message:String, _ guid:String?, _ mailID:String?) -> ()
    typealias RecoverPasswordRequestCompletionHandler = (_ success:Bool, _ code:Int, _ message:String) -> ()
    
    
    static func loginTheUser(userDict:[String:String], complitionHandler handler:@escaping RegistrationRequestCompletionHandler)
    {
        ServerConnectionHelper.postConnectionWithUrl(urlString: FootprintConstant.API.Login, paramas: userDict) { (status, json) in
            
            if status == true
            {
                let message = json!["Message"] as! String
                let responseCode = Int((json!["Code"] as! String))!
                let userGuid = json!["UserGuid"] as? String
                handler(status, responseCode, message, userGuid)
            }else{
                handler(false, -1, FootprintConstant.Alert.SWR, nil)
            }
            
            
        }
    }
    
    static func registerUser(userDict:[String:String], complitionHandler handler:@escaping RegistrationRequestCompletionHandler)
    {
        ServerConnectionHelper.postConnectionWithUrl(urlString: FootprintConstant.API.Registration, paramas: userDict) { (status, json) in
            
            if status == true
            {
                let message = json!["Message"] as! String
                let responseCode = Int((json!["Code"] as! String))!
                let userGuid = json!["UserGuid"] as? String
                handler(status, responseCode, message, userGuid)
            }else{
                handler(false, -1, FootprintConstant.Alert.SWR, nil)
            }
            
            
        }
    }
    
    static func recoverPassword(emailDict:[String:String], complitionHandler handler:@escaping RecoverPasswordRequestCompletionHandler)
    {
        ServerConnectionHelper.postConnectionWithUrl(urlString: FootprintConstant.API.ForgotPassword, paramas: emailDict) { (status, json) in
            
            if status == true
            {
                let message = json!["message"] as! String
                let responseCode = json!["messageCode"] as! Int
                handler(status, responseCode, message)
            }else{
                handler(false, -1, FootprintConstant.Alert.SWR)
            }
        
        }
    }
    
    static func loginWithFB(userDict:[String:String], complitionHandler handler:@escaping FBRegistrationRequestCompletionHandler)
    {
        ServerConnectionHelper.postConnectionWithUrl(urlString: FootprintConstant.API.FBRegistration, paramas: userDict) { (status, json) in
            
            if status == true
            {
                let message = json!["Message"] as! String
                let responseCode = Int((json!["Code"] as! String))!
                let userGuid = json!["UserGuid"] as? String
                let mailId = json!["UserEmail"] as! String
                
                handler(status, responseCode, message, userGuid, mailId)
            }else{
                handler(false, -1, FootprintConstant.Alert.SWR, nil, nil)
            }
            
            
        }
    }
    
}






