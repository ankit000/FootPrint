//
//  RewardPointHelper.swift
//  Footprint
//
//  Created by Abhinay Maurya on 1/9/17.
//  Copyright © 2017 ONS. All rights reserved.
//

import Foundation

struct RewardPoint
{
    let displayRewardPoints:Bool
    let rewardPointsAmount:String?
    let rewardPointsBalance:Int?
    let minimumRewardPointsToUse:Int?
    let minimumRewardPointsToUseAmount:String?
    
    init(record:[String:Any]?) {
        self.displayRewardPoints = record?["displayRewardPoints"] as! Bool
        self.rewardPointsAmount = record?["rewardPointsAmount"] as? String
        self.rewardPointsBalance = record?["rewardPointsBalance"] as? Int
        self.minimumRewardPointsToUse = record?["MinimumRewardPointsToUse"] as? Int
        self.minimumRewardPointsToUseAmount = record?["MinimumRewardPointsToUseAmount"] as? String
    }
}


final class RewardPointHelper
{
    typealias RewardPointRequestCompletionHandler = (_ success:Bool, _ info:RewardPoint?) -> ()
}

//MARK:- API Call
extension RewardPointHelper
{
    //Fetching
    class func fetchRewardPoints(complitionHandler handler:@escaping RewardPointRequestCompletionHandler)
    {
        
        ServerConnectionHelper.postConnectionWithUrl(urlString: FootprintConstant.API.RewardPoint, paramas: [:]) { (status, json) in

            if status == true
            {
                if(json!["status"] as! Bool){
                    if let record = json{
                        let record = RewardPoint(record: record)
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
}
