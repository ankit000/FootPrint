//
//  MyOrderHelper.swift
//  Footprint
//
//  Created by Abhinay Maurya on 15/12/16.
//  Copyright © 2016 ONS. All rights reserved.
//

import Foundation

final class ChangePasswordHelper{
    typealias ChangePasswordRequestCompletionHandler = (_ success:Bool, _ messge:String) -> ()
}

extension ChangePasswordHelper
{
    class func changePassword(param:[String:String],complitionHandler handler:@escaping ChangePasswordRequestCompletionHandler)
    {
        let myOrderURLString = FootprintConstant.API.ChangePassword
        
        ServerConnectionHelper.postConnectionWithUrl(urlString:myOrderURLString, paramas: param) { (status, json) in
            
                if status == true
                {
                    if(json!["status"]as! Bool){
                        
                        handler(true,"Success")
                    }else{
                        handler(false,"Failed")
                    }
                }else{
                    handler(false,"Failed")
                }
            }
        
    }
    
}
