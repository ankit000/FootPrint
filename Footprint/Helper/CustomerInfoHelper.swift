//
//  CustomerInfoHelper.swift
//  Footprint
//
//  Created by Abhinay Maurya on 1/7/17.
//  Copyright © 2017 ONS. All rights reserved.
//

import Foundation

struct CustomerInfo
{
    let firstName:String?
    let lastName:String?
    let username:String?
    let email:String!
    let dateOfBirthDay:Int?
    let dateOfBirthMonth:Int?
    let dateOfBirthYear:Int?
    let gender:String?
    let company:String?
    let newsletterEnabled:Bool!
    
    init(userInfo:[String:Any]?)
    {
        self.firstName = userInfo?["FirstName"] as? String
        self.lastName  = userInfo?["LastName"] as? String
        self.username  = userInfo?["Username"] as? String
        self.gender    = userInfo?["Gender"] as? String
        self.company   = userInfo?["Company"] as? String
        self.email     = (userInfo?["Email"] as! String)
        self.dateOfBirthDay    = userInfo?["DateOfBirthDay"] as? Int
        self.dateOfBirthMonth  = userInfo?["DateOfBirthMonth"] as? Int
        self.dateOfBirthYear   = userInfo?["DateOfBirthYear"] as? Int
        self.newsletterEnabled = (userInfo?["NewsletterEnabled"] as! Bool)
    }
}


final class CustomerInfoHelper{
    typealias CustomerInfoRequestCompletionHandler = (_ success:Bool, _ info:CustomerInfo?) -> ()
    typealias UpdateInfoRequestCompletionHandler = (_ success:Bool, _ message:String) -> ()
    
}

//MARK:- API Call
extension CustomerInfoHelper
{
    //Fetching
    class func fetchCustomerInfo(complitionHandler handler:@escaping CustomerInfoRequestCompletionHandler)
    {
        ServerConnectionHelper.postConnectionWithUrl(urlString: FootprintConstant.API.CustomerInfo, paramas: [:]) { (status, json) in

            
            if status == true
            {
                if let dict = json{
                    if let model = dict["model"] as? [String:Any]{
                        let record = CustomerInfo(userInfo: model)
                        handler(true, record)
                    }else{
                        handler(false, nil)
                    }
                }else{
                    handler(false, nil)
                }
            }else{
                handler(false, nil)
            }
        }
    }
    
    //Updation
    class func updateUserInfo(email emailID:String, firstName fn:String, lastName ln:String, gender gen:String, dob dateOfBirth:String, dateOfBirthDay day:String, dateOfBirthMonth month:String, dateOfBirthYear year:String, company comp:String, complitionHandler handler:@escaping UpdateInfoRequestCompletionHandler)
    {
        guard let _ = UserRecordHelper.sharedInstance.userRecord?.userGUID else {
            handler(false, "Something went wrong!!")
            return
        }
        
        let params = ["Email":emailID, "Gender":gen, "FirstName":fn, "LastName":ln, "Dob":dateOfBirth, "DateOfBirthDay":day, "DateOfBirthMonth":month, "DateOfBirthYear":year, "Company":comp]
        
        ServerConnectionHelper.postConnectionWithUrl(urlString: FootprintConstant.API.UpdateUserInfo, paramas: params) { (status, json) in
            
            let message = json!["message"] as! String
            if status == true
            {
                handler(true, message)
            }else{
                handler(false, message)
            }
            
        }
    }
    
}
