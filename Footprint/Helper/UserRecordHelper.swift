//
//  UserRecordHelper.swift
//  Footprint
//
//  Created by Abhinay Maurya on 18/10/16.
//  Copyright © 2016 ONS. All rights reserved.
//

import Foundation

struct UserRecord
{
    var userEmail:String?
    var userGUID:String?
    var userDOB:String?
    
    init(record:[String:Any]?){
        self.userEmail = record?[UserRecordHelper.Key.UserEmail] as? String
        self.userGUID = record?[""] as? String
        self.userDOB = record?[""] as? String
    }
    
    init(userEmail:String?, userGUID:String?, userDOB:String?){
        self.userEmail = userEmail
        self.userGUID = userGUID
        self.userDOB = userDOB
    }
    
}

//MARK:- Class
final class UserRecordHelper
{
    static let sharedInstance = UserRecordHelper()
    
    //MARK:- Private Vars
    fileprivate let prefs = UserDefaults.standard
   
    fileprivate var record:UserRecord?{
        get{
           return UserRecord(userEmail: prefs.object(forKey: UserRecordHelper.Key.UserEmail) as? String, userGUID: prefs.object(forKey: UserRecordHelper.Key.UserGuid) as? String, userDOB: prefs.object(forKey: UserRecordHelper.Key.UserDOB) as? String)
        }set{
            prefs.setValue(newValue?.userEmail, forKey: UserRecordHelper.Key.UserEmail)
            prefs.setValue(newValue?.userGUID, forKey: UserRecordHelper.Key.UserGuid)
            prefs.setValue(newValue?.userDOB, forKey: UserRecordHelper.Key.UserDOB)
        }
    }
    
    //MARK:- Public Vars
    var isLogin:Bool{
        get{
            return prefs.bool(forKey: Key.IsLogin)
        }set{
            prefs.set(newValue, forKey: Key.IsLogin)
            if newValue == false{
                userRecord = nil
               // cookie = nil
            }
            
            prefs.synchronize()
        }
    }
    
    var userRecord:UserRecord?{
        get{
            return self.record
        }
        set{
            if let newValue = newValue{
                self.record = newValue
            }else{
                prefs.removeObject(forKey: Key.UserEmail)
                prefs.removeObject(forKey: Key.UserGuid)
                prefs.removeObject(forKey: Key.UserDOB)
            }
            prefs.synchronize()
        }
    }
    
//    var cookie:HTTPCookie?{
//        get{
//            let cookieProperties = prefs.value(forKey: "Cookie")
//            return HTTPCookie(properties: cookieProperties as! [HTTPCookiePropertyKey : Any])
//        }set{
//            prefs.set(newValue?.properties, forKey: "Cookie")
//            prefs.synchronize()
//        }
//    }
    
    func logout(){
        isLogin = false
        //Fb Logout
        FBLoginHelper.logout()
    }
}

//MARK:- Extension
extension UserRecordHelper
{
    struct Key {
        static let UserEmail = "UserEmail"
        static let UserGuid = "UserGuid"
        static let UserDOB = "UserDOB"
        static let IsLogin = "isLogin"
    }

}
