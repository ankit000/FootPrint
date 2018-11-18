//
//  DashboardHelper.swift
//  Footprint
//
//  Created by Abhinay on 05/09/18.
//  Copyright © 2018 ONS. All rights reserved.
//

import Foundation

enum DashboardConstantSection:String
{
    case BLOG, PLUS
    static func totalSection() -> Int{
        return 2
    }
}

struct DashboardRecord
{
    let id:Int!
    let title:String!
    let thumbUrl:String!
    var imageHeight:Double?
    
    init(dict:[String:Any]){
        self.id = dict["id"] as! Int
        self.title = dict["title"] as! String
        self.thumbUrl = dict["thumbUrl"] as! String
    }
}

final class DashboardHelper
{
    static let shared = DashboardHelper()
    
    typealias DashboardCompletionHandler = (_ success:Bool, _ records:[DashboardRecord]) -> ()
    
    
    func getDashboardSection(completionHandler handler:@escaping DashboardCompletionHandler)
    {
        let vendorId = DashboardHelper.VendorID
        
        ServerConnectionHelper.postConnectionWithUrl(urlString: FootprintConstant.API.Dashboard, paramas: ["vendorId":vendorId]) { (status, json) in
            
            var records = [DashboardRecord]()
            if status == true
            {
                let models = json!["model"] as! [[String:Any]]
                for model in models{
                    let record = DashboardRecord(dict: model)
                    records.append(record)
                }
            }
            
            //Adding default records
            let blogRecord = DashboardRecord(dict: ["id":0, "title":"BLOG", "thumbUrl":""])
            let plusRecord = DashboardRecord(dict: ["id":1, "title":"PLUS", "thumbUrl":""])
            records.append(blogRecord)
            records.append(plusRecord)
            
            handler(status, records)
        }
    }
}

//Keys
extension DashboardHelper
{
    static let VendorID = 10
}
