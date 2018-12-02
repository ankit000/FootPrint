//
//  GiftCardBalanceVC.swift
//  Footprint
//
//  Created by Abhinay Maurya on 15/12/16.
//  Copyright © 2016 ONS. All rights reserved.
//

import UIKit

class GiftCardBalanceVC: HeaderVC
{
    //MARK:- IBOutlet
    @IBOutlet fileprivate weak var txtGiftCardNumber: UITextField!
    @IBOutlet fileprivate weak var txtPin: UITextField!
    
    //MARK:- ViewC Life Cycle
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
        pageTitle = "GIFT CARD BALANCE"
    }
    fileprivate func pageAppearance(){
        self.view.backgroundColor = FootprintConstant.Color.FootprintBlueColor
        isHideBackgroundImage = true
    }
    
    //MARK:- IBAction
    
    @IBAction func checekBalanceAction(_ sender: UIButton) {
    }

}

/* ---------------------------------- Extension ----------------------------------------- */
//MARK:- Extension
extension GiftCardBalanceVC
{
    struct Storyboard{
        static let ControllerID = String(describing: GiftCardBalanceVC.self)
        static let SegueID = "GiftCardBalanceSegue"
    }
    
    //MARK:- Static Metod
    static func instantiate() -> GiftCardBalanceVC{
        let storyboard = UIStoryboard(name: FootprintConstant.Storyboard.Main, bundle: Bundle.main)
        return storyboard.instantiateViewController(withIdentifier: Storyboard.ControllerID) as! GiftCardBalanceVC
    }
}

