//
//  ContactVC.swift
//  Footprint
//
//  Created by Abhinay Maurya on 29/11/16.
//  Copyright © 2016 ONS. All rights reserved.
//

import UIKit

class ContactVC: ProductSuperVC
{
    //MARK:- IBOutlets
    @IBOutlet fileprivate weak var tableView:UITableView!
    @IBOutlet fileprivate weak var btnSubmit:UIButton!
    
    
    //MARK:- Public Var
    var delegate:ProductShareDelegate?
    
    //MARK:- Private Var
    fileprivate let dataSource = ContactUsHelper.dataSource
    fileprivate var params = [String:String]()
    
    //MARK:- ViewC life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        pageAppearance()
        initialSetting()
    }
    
    //MARK:- Private Methods
    fileprivate func pageAppearance(){
        btnSubmit.backgroundColor = FootprintConstant.Color.FootprintBlueColor
        btnSubmit.titleLabel?.font = UIFont(name: FootprintConstant.Font.Montserrat.Regular, size: 17.0)
    }
    
    fileprivate func  initialSetting()
    {
        self.pageTitle = "Contact".uppercased()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.isScrollEnabled = false
        
        TextFieldCell.registerNib(tableView: tableView)
        TextViewCell.registerNib(tableView: tableView)
    }
    
    //MARK:- IBAction
    
    @IBAction func tapAction(_ sender: UITapGestureRecognizer) {
        delegate?.closeMediaView()
    }
    
    //MARK:- Touch Delegate
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }

}


/* ---------------------------------- Extension ----------------------------------------- */
//MARK:- Extension
extension ContactVC
{
    struct Storyboard
    {
        static let ControllerID = String(describing: ContactVC.self)
        static let SegueID = "ContactSegue"
    }
    
    struct CellConstant {
        static let TextFieldHeight:CGFloat = 54.0
    }
    
    //MARK:- Static Metod
    static func instantiate() -> ContactVC{
        let storyboard = UIStoryboard(name: FootprintConstant.Storyboard.MyAccount, bundle: Bundle.main)
        return storyboard.instantiateViewController(withIdentifier: Storyboard.ControllerID) as! ContactVC
    }
    
}


extension ContactVC:UITableViewDelegate
{
}

extension ContactVC:UITableViewDataSource
{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        if dataSource[indexPath.row].isTextView == false{
            return CellConstant.TextFieldHeight
        }
        else{
            let textFieldsHeight = CGFloat((dataSource.count - ContactUsHelper.numberOfTextView)) * CellConstant.TextFieldHeight
            let tableViewHeight = tableView.frame.size.height
            let cellHeight = tableViewHeight - textFieldsHeight
            return cellHeight > CellConstant.TextFieldHeight ? cellHeight : CellConstant.TextFieldHeight
        }
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count
    }
    
   
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        if dataSource[indexPath.row].isTextView == false
        {
            let cell = tableView.dequeueReusableCell(withIdentifier: TextFieldCell.Constant.Identifier) as! TextFieldCell
            cell.delegate = self
            cell.contactRecord = dataSource[indexPath.row]
            return cell
        }else{
            let cell = tableView.dequeueReusableCell(withIdentifier: TextViewCell.Constant.Identifier) as! TextViewCell
            cell.delegate = self
            cell.contactRecord = dataSource[indexPath.row]
            return cell
        }
        
    }
}


extension ContactVC:UITextFieldDelegate
{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}

extension ContactVC:TextViewCellDelegate, TextFieldCellDelegate
{
    func set(value: String?, forKey: String) {
        if let value = value{
            params[forKey] = value
        }
    }
}



