//
//  OrderCell.swift
//  Footprint
//
//  Created by Abhinay Maurya on 2/7/17.
//  Copyright © 2017 ONS. All rights reserved.
//

import UIKit

class OrderCell: UITableViewCell
{
    //MARK:- IBOutlet
    @IBOutlet fileprivate weak var lblSku: UILabel!
    @IBOutlet fileprivate weak var lblName: UILabel!
    @IBOutlet fileprivate weak var lblQty: UILabel!
    @IBOutlet fileprivate weak var lblPrice: UILabel!
    @IBOutlet fileprivate weak var viewContainer: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        viewContainer.drawBorder(cornerRadius: 5.0, borderWidth: 1.0, borderColor: FootprintConstant.Color.FootprintBlueColor, maskToBound: true)
    }
    
    //MARK:- Public Var
    var data:OrderItem!{
        didSet{
          lblSku.text = "SKU #" + data.sku
          lblName.text = data.name
          lblQty.text = "Qty:" + "\(data.quantity!)"
          lblPrice.text = data.unitPrice
        }
    }
}
/* ---------------------------------- Extension --------------------------------------- */
//MARK:- Extension
extension OrderCell
{
    struct Constant {
        static let Identifier = String(describing: OrderCell.self)
        static let Height:CGFloat = 175.0
    }
    
    static func registerNib(tableView:UITableView){
        tableView.register(UINib(nibName: Constant.Identifier, bundle: nil), forCellReuseIdentifier: Constant.Identifier)
    }
    
}
