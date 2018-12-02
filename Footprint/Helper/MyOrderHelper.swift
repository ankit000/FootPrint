//
//  MyOrderHelper.swift
//  Footprint
//
//  Created by Abhinay Maurya on 15/12/16.
//  Copyright © 2016 ONS. All rights reserved.
//

import Foundation

struct Order
{
    let id:Int!
    let orderTotal:String!
    let isReturnRequestAllowed:Bool!
    let orderStatusEnum:Int!
    let paymentStatus:String!
    let orderStatus:String!
    let shippingStatus:String!
    let createdOn:String!
    let customProperties:Any?
    
    init(order:[String:Any])
    {
        self.id = order["Id"] as! Int
        self.orderTotal = order["OrderTotal"] as! String
        self.isReturnRequestAllowed = order["IsReturnRequestAllowed"] as! Bool
        self.orderStatusEnum = order["OrderStatusEnum"] as! Int
        self.paymentStatus = order["PaymentStatus"] as! String
        self.orderStatus = order["OrderStatus"] as! String
        self.shippingStatus = order["ShippingStatus"] as! String
        self.createdOn = order["CreatedOn"] as! String
        self.customProperties = order["OrderTotal"]
    }
}


final class MyOrderHelper{
    typealias MyOrderRequestCompletionHandler = (_ success:Bool, _ orderRecords:[Order]) -> ()
}

extension MyOrderHelper
{
    class func getCustomerOrders(complitionHandler handler:@escaping MyOrderRequestCompletionHandler)
    {
        let myOrderURLString = FootprintConstant.API.CustomerOrders
        
        ServerConnectionHelper.postConnectionWithUrl(urlString:myOrderURLString, paramas: [:]) { (status, json) in
            
                var myOrders = [Order]()
                if status == true
                {
                    if let oRecords = ((json)?["model"] as? [String:Any])?["Orders"] as? [[String:Any]]{
                        for order in oRecords{
                            let record = Order(order: order)
                            myOrders.append(record)
                        }
                        handler(true, myOrders)
                    }else{
                        handler(false, myOrders)
                    }
            
                }else{
                    handler(false, myOrders)
                }
            }
        
    }
    
}
