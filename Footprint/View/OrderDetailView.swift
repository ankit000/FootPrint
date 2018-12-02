//
//  OrderDetailView.swift
//  Footprint
//
//  Created by Abhinay Maurya on 2/8/17.
//  Copyright © 2017 ONS. All rights reserved.
//

import UIKit

class OrderDetailView: UIView
{
    //MARK:- Private Vars
    
    
    //MARK:- IBoutlet
    @IBOutlet fileprivate weak var lblSku: UILabel!
    @IBOutlet fileprivate weak var lblOrderDate: UILabel!
    @IBOutlet fileprivate weak var lblOrderTotal: UILabel!
    @IBOutlet fileprivate weak var lblStatus: UILabel!
    @IBOutlet fileprivate weak var lblUserName: UILabel!
    @IBOutlet fileprivate weak var lblUserAddress: UILabel!
    @IBOutlet fileprivate weak var lblPaymentMethod: UILabel!
    @IBOutlet fileprivate weak var lblShippingMethod: UILabel!
    
    var detail:OrderDetail! {
        didSet{
            lblSku.text = "SKU # \(detail.id!)"
            lblOrderDate.text = "Order Date: \(detail.orderTime!)"
            lblOrderTotal.text = "Order Total: \(detail.orderTotal!)"
            lblStatus.text = "Status: \(detail.status!)"
            lblUserName.text = detail.userName
            lblUserAddress.text = detail.userAddress
            lblPaymentMethod.text = "Payment Method: \(detail.paymentMethod!)"
            lblShippingMethod.text = "Shipping Method: \(detail.shippingMethod!)"
        }
    }
    
    //MARK:- Public Var

}
//MARK:- Extension
extension OrderDetailView
{
    struct Constant {
        static let Height:CGFloat = 370.0
    }
    
    //MARK:- Static Metod
    static func instantiate() -> OrderDetailView{
        let views = Bundle.main.loadNibNamed("OrderDetailView", owner: self, options: nil)
        return views![0] as! OrderDetailView
        
    }
    
}
