//
//  HomeViewController.swift
//  Footprint
//
//  Created by Ankit Katiyar on 17/11/18.
//  Copyright © 2018 ONS. All rights reserved.
//

import UIKit

class ShoesCategoryVC: SuperContainerVC {
    
    //IBOutlets
    
    @IBOutlet weak var tblShoesCategory: UITableView!
    
    var categryArray = [ShoesCategory]()
    
    // MARK: Life Cycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        self.getCategory()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
    }
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(true)
    }
    
    //MARK:- Api call
    
    func getCategory()  {
        
        showLoadIndicator(title: "")
        ShoesPageHelper.getShoesCategory(params: ["vendorId":"10"]) { (staus, data) in
            self.hideLoadIndicator()
            self.categryArray = data
            self.tblShoesCategory.reloadData()
        }
        
    }
    
    //MARK:-
    override var prefersStatusBarHidden: Bool{
        return true
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

/* ---------------------------------- Extension ----------------------------------------- */
//MARK:- Extension

extension ShoesCategoryVC:UITableViewDataSource, UITableViewDelegate  {
    // MARK: - UITableview Datasource and Delegate
    
    // number of rows in table view
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.categryArray.count
    }
    
    // create a cell for each table view row
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let categoryCell: shoesCategoryCell = tableView.dequeueReusableCell(withIdentifier: "CategoryCell", for: indexPath) as! shoesCategoryCell
        categoryCell.setData(category:  self.categryArray[indexPath.row])
        return categoryCell
        
    }

    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
    
    
    // method to run when table view cell is tapped
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("You tapped cell number \(indexPath.row).")
        
    }
    
}
