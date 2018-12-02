//
//  OrderDetailHelper.swift
//  Footprint
//
//  Created by Abhinay Maurya on 2/7/17.
//  Copyright © 2017 ONS. All rights reserved.
//

import Foundation


struct OrderDetail
{
    let id:Int!
    let orderTotal:String!
    let orderStatus:String!
    let userName:String!
    let userAddress:String!
    let paymentMethod:String!
    let shippingMethod:String!
    let orderTime:String!
    let status:String!
    let items:[OrderItem]!
    
    init(detail:[String:Any])
    {
        let shippingAddress = detail["ShippingAddress"] as! [String:Any]
        
        self.id = detail["Id"] as! Int
        self.orderTotal = detail["OrderTotal"] as! String
        self.orderStatus = detail["OrderStatus"] as! String
        self.userName = shippingAddress["FirstName"] as! String
        self.userAddress = shippingAddress["Address1"] as! String
        self.paymentMethod = detail["PaymentMethod"] as! String
        self.shippingMethod = detail["ShippingMethod"] as! String
        self.orderTime = detail["CreatedOn"] as! String
        self.status = detail["PaymentMethodStatus"] as! String
        
        var oItems = [OrderItem]()
        if let items = detail["Items"] as? [[String:Any]]{
            for item in items{
                let oItem = OrderItem(item: item)
                oItems.append(oItem)
            }
        }
        
        self.items = oItems

    }
}

struct OrderItem
{
    let sku:String!
    let name:String!
    let quantity:Int!
    let unitPrice:String!
    let subTotalPrice:String!
    let id:Int!
    let productId:Int!
    let attributeInfo:String!
    
    init(item:[String:Any]){
        self.sku = item["Sku"] as! String
        self.name = item["ProductName"] as! String
        self.quantity = item["Quantity"] as! Int
        self.unitPrice = item["UnitPrice"] as! String
        self.subTotalPrice = item["SubTotal"] as! String
        self.attributeInfo = item["AttributeInfo"] as! String
        self.id = item["Id"] as! Int
        self.productId = item["ProductId"] as! Int
        
    }
}


final class OrderDetailHelper{
    typealias OrderDetailHelperRequestCompletionHandler = (_ success:Bool, _ orderDetail:OrderDetail?) -> ()
}

extension OrderDetailHelper
{
    class func getOrderDetail(orderId:String, complitionHandler handler:@escaping OrderDetailHelperRequestCompletionHandler)
    {
        let myOrderURLString = FootprintConstant.API.OrderDetail + orderId
        
        ServerConnectionHelper.postConnectionWithUrl(urlString:myOrderURLString, paramas: [:]) { (status, json) in
            
            if status == true
            {
                if let orderDetail = json{
                    let oDetail = OrderDetail(detail: orderDetail)
                    handler(true, oDetail)
                }else{
                    handler(false, nil)
                }
                
            }else{
                handler(false, nil)
            }
        }
        
    }
    
}
