//
//  OrderDetailVC.swift
//  Footprint
//
//  Created by Abhinay Maurya on 2/7/17.
//  Copyright © 2017 ONS. All rights reserved.
//

import UIKit

class OrderDetailVC: HeaderVC
{
    //MARK:- IBOutlets
    @IBOutlet fileprivate weak var tableView:UITableView!
    
    //MARK:- Private Vars
    fileprivate var dataSource = [OrderItem]()
    fileprivate var orderDetail:OrderDetail?
    
    //MARK:- Public Vars
    var orderId:String!{
        didSet{
            self.loadOrderDetail()
        }
    }
    
    //MARK:-
    override func viewDidLoad() {
        super.viewDidLoad()
        self.initialSetting()
        self.pageAppearance()
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    //MARK:- Private Methods
    fileprivate func initialSetting(){
        
        pageTitle = "ORDER DETAIL"
        tableView.delegate = self
        tableView.dataSource = self
        
        OrderCell.registerNib(tableView: tableView)
    }
    fileprivate func pageAppearance(){
        isHideBackgroundImage = true
        self.view.backgroundColor = WhiteColor
        self.tableView.backgroundColor = WhiteColor
    }
    
    fileprivate func loadOrderDetail()
    {
        self.showLoadIndicator(title: "Fetching..")
        OrderDetailHelper.getOrderDetail(orderId: orderId) {[weak self] (status, detail) in
            
            self?.hideLoadIndicator()
            if status
            {
                self?.dataSource.removeAll()
                self?.orderDetail = detail
                self?.dataSource = detail!.items
                self?.tableView.reloadData()
                
                let headerView = OrderDetailView.instantiate()
                headerView.detail = self?.orderDetail
                self?.tableView.tableHeaderView = headerView
            }else{
                self?.showAlert(title: FootprintConstant.Alert.Error, message: "Something went wrong!!")
            }
            
        }
    }
}

/* ---------------------------------- Extension ----------------------------------------- */
//MARK:- Extension
extension OrderDetailVC
{
    struct Storyboard{
        static let ControllerID = String(describing: OrderDetailVC.self)
        static let SegueID = "OrderDetailSegue"
    }
    
    //MARK:- Static Metod
    static func instantiate() -> OrderDetailVC{
        let storyboard = UIStoryboard(name: FootprintConstant.Storyboard.Order, bundle: Bundle.main)
        return storyboard.instantiateViewController(withIdentifier: Storyboard.ControllerID) as! OrderDetailVC
    }
}


extension OrderDetailVC:UITableViewDataSource
{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return OrderCell.Constant.Height
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: OrderCell.Constant.Identifier) as! OrderCell
        return cell
    }
}

extension OrderDetailVC:UITableViewDelegate
{
//    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
//        return OrderDetailView.Constant.Height
//    }
//    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView?
//    {
//        let headerView = OrderDetailView.instantiate()
//        headerView.detail = orderDetail
//        return headerView
//    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        (cell as! OrderCell).data = dataSource[indexPath.row]
    }
    
}

