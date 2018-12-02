//
//  MyOrdersVC.swift
//  Footprint
//
//  Created by Abhinay Maurya on 15/12/16.
//  Copyright © 2016 ONS. All rights reserved.
//

import UIKit

class MyOrdersVC: HeaderVC
{
    //MARK:- IBOutlets
    @IBOutlet fileprivate weak var tableView:UITableView!
    
    //MARK:- Private Methods
    fileprivate var dataSource = [Order]()
    
    //MARK:-
    override func viewDidLoad() {
        super.viewDidLoad()
        self.initialSetting()
        self.pageAppearance()
        self.loadMyOrders()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    //MARK:- Private Methods
    fileprivate func initialSetting(){
        
        pageTitle = "MY ORDERS"
        tableView.delegate = self
        tableView.dataSource = self
        
        MyOrderCell.registerNib(tableView: tableView)
    }
    fileprivate func pageAppearance(){
        isHideBackgroundImage = true
        self.view.backgroundColor = FootprintConstant.Color.FootprintBlueColor
        self.tableView.backgroundColor = FootprintConstant.Color.FootprintBlueColor
    }
    
    fileprivate func loadMyOrders()
    {
        self.showLoadIndicator(title: "Fetching..")
        MyOrderHelper.getCustomerOrders {[weak self] (status, orders) in
            
            self?.hideLoadIndicator()
            if status{
                self?.dataSource.removeAll()
                self?.dataSource = orders
                self?.tableView.reloadData()
            }else{
               self?.showAlert(title: FootprintConstant.Alert.Error, message: "Something went wrong!!")
            }
            
        }
    }
    
    //MARK:-
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == OrderDetailVC.Storyboard.SegueID{
            
            let indexPath = sender as! IndexPath
            let vc = segue.destination as! OrderDetailVC
            vc.orderId = "\(dataSource[indexPath.row].id!)"
        }
    }
}

/* ---------------------------------- Extension ----------------------------------------- */
//MARK:- Extension
extension MyOrdersVC
{
    struct Storyboard{
        static let ControllerID = String(describing: MyOrdersVC.self)
        static let SegueID = "MyOrdersSegue"
    }
    
    //MARK:- Static Metod
    static func instantiate() -> MyOrdersVC{
        let storyboard = UIStoryboard(name: FootprintConstant.Storyboard.Main, bundle: Bundle.main)
        return storyboard.instantiateViewController(withIdentifier: Storyboard.ControllerID) as! MyOrdersVC
    }
}

extension MyOrdersVC:UITableViewDataSource
{
    func numberOfSections(in tableView: UITableView) -> Int {
        return dataSource.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return MyOrderCell.Constant.Height
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Order Number: \(dataSource[section].id!)".uppercased()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: MyOrderCell.Constant.Identifier) as! MyOrderCell
        return cell
    }
}

extension MyOrdersVC:UITableViewDelegate
{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: OrderDetailVC.Storyboard.SegueID, sender: indexPath)
        self.tableView.deselectRow(at: indexPath, animated: true)
        
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        (cell as! MyOrderCell).data = dataSource[indexPath.section]
    }
    
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        view.tintColor = FootprintConstant.Color.FootprintGreenColor
        (view as! UITableViewHeaderFooterView).textLabel?.textColor = WhiteColor
    }
}

