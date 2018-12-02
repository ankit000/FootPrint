//
//  ChangePasswordVC.swift
//  Footprint
//
//  Created by Abhinay Maurya on 15/12/16.
//  Copyright © 2016 ONS. All rights reserved.
//

import UIKit

class ChangePasswordVC: HeaderVC
{
    //MARK:- IBOutlet
    @IBOutlet fileprivate weak var txtOldPassword: UITextField!
    @IBOutlet fileprivate weak var txtNewPassword: UITextField!
    @IBOutlet fileprivate weak var txtConfirmPassword: UITextField!

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
        pageTitle = "CHANGE PASSWORD"
    }
    fileprivate func pageAppearance(){
        self.view.backgroundColor = FootprintConstant.Color.FootprintBlueColor
        isHideBackgroundImage = true
    }

    //MARK:- IBAction

    @IBAction func changePasswordAction(_ sender: UIButton) {
        
        
        if((txtOldPassword.text?.count)! > 0 && (txtNewPassword.text?.count)! > 0 && (txtConfirmPassword.text?.count)! > 0){
            if(txtNewPassword.text == txtConfirmPassword.text){
                
                self.showLoadIndicator(title: "")

                let dict = ["OldPassword":txtOldPassword.text!, "NewPassword":txtNewPassword.text!, "ConfirmNewPassword":txtConfirmPassword.text!] as [String : Any]
                
                ChangePasswordHelper.changePassword(param: dict as! [String : String]) { (status, message) in
                    self.hideLoadIndicator()
                    if(status == true){
                        self.showAlert(title: FootprintConstant.Alert.Success, message: "Password Changed Succesfully")
                    }else{
                        self.showAlert(title: FootprintConstant.Alert.Error, message: "Something went wrong!!")
                    }
                }

            }else{
                self.showAlert(title: FootprintConstant.Alert.Error, message: "Password does not match")

            }
        }else{
            self.showAlert(title: FootprintConstant.Alert.Warning, message: "Kindly fill all the fields")
        }
        
    }
}

/* ---------------------------------- Extension ----------------------------------------- */
//MARK:- Extension
extension ChangePasswordVC
{
    struct Storyboard{
        static let ControllerID = String(describing: ChangePasswordVC.self)
        static let SegueID = "ChangePasswordSegue"
    }
    
    //MARK:- Static Metod
    static func instantiate() -> ChangePasswordVC{
        let storyboard = UIStoryboard(name: FootprintConstant.Storyboard.MyAccount, bundle: Bundle.main)
        return storyboard.instantiateViewController(withIdentifier: Storyboard.ControllerID) as! ChangePasswordVC
    }
}
