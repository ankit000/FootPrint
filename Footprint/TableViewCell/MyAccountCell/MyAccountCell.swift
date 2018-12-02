//
//  MyAccountCell.swift
//  Footprint
//
//  Created by Abhinay Maurya on 14/12/16.
//  Copyright © 2016 ONS. All rights reserved.
//

import UIKit

class MyAccountCell: UITableViewCell
{

    //MARK:- IBOutlet
    @IBOutlet fileprivate weak var lblTitle: UILabel!
    @IBOutlet fileprivate weak var lblSeperator: UILabel!
    
    //MARK:- Public Var
    var data:MyAccountRecord!{
        didSet{
            lblTitle.text = data.title.uppercased()
        }
    }
    
    var isHideSeperator = false{
        didSet{
            lblSeperator.isHidden = isHideSeperator
        }
    }
    
    override func awakeFromNib() {
        self.backgroundColor = FootprintConstant.Color.FootprintBlueColor
    }
    
}
/* ---------------------------------- Extension --------------------------------------- */
//MARK:- Extension
extension MyAccountCell
{
    struct Constant {
        static let Identifier = String(describing: MyAccountCell.self)
    }
    
    static func registerNib(tableView:UITableView){
        tableView.register(UINib(nibName: Constant.Identifier, bundle: nil), forCellReuseIdentifier: Constant.Identifier)
    }
    
}
