//
//  ShoesPageHelper.swift
//  Footprint
//
//  Created by Ankit katiyar on 23/11/18.
//  Copyright © 2018 Ankit katiyar. All rights reserved.
//

import Foundation

final class ShoesPageHelper
{
    let sharedInstance = ShoesPageHelper()
}


//MARK:- API Call
extension ShoesPageHelper
{
    typealias categoryRequestCompletionHandler = (_ success:Bool, _ data:[ShoesCategory]) -> ()
    
    
    static func getShoesCategory(params:[String:String], complitionHandler handler:@escaping categoryRequestCompletionHandler)
    {
        ServerConnectionHelper.postConnectionWithUrl(urlString: FootprintConstant.API.Dashboard, paramas: params) { (status, json) in
            
            if status == true
            {
                let categoryArray = ShoesCategory.modelsFromDictionaryArray(array: (json!["model"] as! [String:Any])["categories"] as! NSArray)
                handler(status,categoryArray)
            }else{
                handler(false, [])
            }
        }
        
    }
    
}






