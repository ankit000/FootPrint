//
//  Login.swift
//  Footprint
//
//  Created by Abhinay Maurya on 03/10/16.
//  Copyright © 2016 ONS. All rights reserved.
//

//https://developer.linkedin.com/docs/ios-sdk#!
//

import UIKit
//import FacebookCore
//import FacebookLogin

class LoginVC: UIViewController
{
    //MARK:- IBOutlets
    @IBOutlet fileprivate weak var txtUserName: UITextField!
    @IBOutlet fileprivate weak var txtPassword: UITextField!
    
    
    // MARK: Life Cycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        initialSetting()
        pageAppearace()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.navigationController?.setNavigationBarHidden(true, animated: false)
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
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    //MARK:- Private Methods
    fileprivate func initialSetting(){
    }
    
    fileprivate func pageAppearace(){
        view.backgroundColor = FootprintConstant.Color.FootprintBlueColor
    }
    fileprivate func clearData(){
        txtPassword.text = ""
        txtUserName.text = ""
    }
    
    //MARK: Custom Methods
    
    func backToHome() {
        
        let controllers = self.navigationController?.viewControllers
        for vc in controllers! {
            if vc is HomeViewController {
                _ = self.navigationController?.popToViewController(vc as! HomeViewController, animated: true)
            }
        }
    }
    
    
    //MARK:- IBAction
    @IBAction fileprivate func logInAction()
    {
        
        view.endEditing(true)
       // moveToStoryboard(name: FootprintConstant.Storyboard.Main)
        //present(LeftMenuNVC.instantiate(), animated: true, completion: nil)
        
//        let window = UIApplication.shared.keyWindow!
//
//        UIView.animate(withDuration: 0.05) {
//            let vc = HomeViewController.instantiate()
//            window.rootViewController = vc
//        }
//        return
        
        
        
        if (txtPassword.text?.characters.count)! > 0 && (txtUserName.text?.characters.count)! > 0
        {
            
            if !(txtUserName.text?.isValidEmail())!{
                self.showAlert(title: FootprintConstant.Alert.Warning, message: FootprintConstant.AlertMessage.NotValidEmail)
                return
            }
            
            showLoadIndicator(title: "Login...")
            let dict = ["Email":txtUserName.text!, "Username":"", "Password":txtPassword.text!]
            LoginPageHelper.loginTheUser(userDict: dict, complitionHandler: {[weak self] (status, responseCode, message, guid) in
                self?.hideLoadIndicator()
                
                if responseCode == FootprintConstant.APIResponseCode.LoginSuccess
                {
                    if let userGuid = guid
                    {
                        //Save record in local

                       
                        let userRecord = UserRecord(userEmail: dict["Email"], userGUID: userGuid, userDOB:"5-12-2018")
                        UserRecordHelper.sharedInstance.userRecord = userRecord
                        UserRecordHelper.sharedInstance.isLogin = true
                        UserRecordHelper.sharedInstance.storeCookies()
                        self?.showOkAlert(title: FootprintConstant.Alert.Success, message: message, completionHandler: { (status) in
                            //Navigate to home page
                            
                            self?.backToHome()
                           // self?.present(LeftMenuNVC.instantiate(), animated: true, completion: nil)
                        })
                    }else{
                        self?.showOkAlert(title: FootprintConstant.Alert.Ops, message: message, completionHandler: { (status) in
                            self?.clearData()
                        })
                    }
                    
                    
                }else if responseCode == FootprintConstant.APIResponseCode.RegistrationError
                {
                    self?.showOkAlert(title: FootprintConstant.Alert.Ops, message: message, completionHandler: { (status) in
                        self?.clearData()
                    })
                }
            })
        }
        else{
            self.showAlert(title: FootprintConstant.Alert.Warning, message: "Please fill all the fields!")
        }
       
    }
    
    @IBAction fileprivate func fbAction()
    {
        showLoadIndicator(title: "FB Login...")
        
        FBLoginHelper.login(completionHandler: { [weak self] (success, responseCode, message, guid, mailId) in
        
            self?.hideLoadIndicator()
            
            if responseCode == FootprintConstant.APIResponseCode.FBSuccess
            {
                if let userGuid = guid
                {
                    //Save record in local
                    let userRecord = UserRecord(userEmail: mailId!, userGUID: userGuid, userDOB: "")
                    UserRecordHelper.sharedInstance.userRecord = userRecord
                    //UserRecordHelper.sharedInstance.isLogin = true
                    
                    self?.showOkAlert(title: FootprintConstant.Alert.Success, message: message, completionHandler: { (status) in
                        //Navigate to home page
                        self?.moveToStoryboard(name: FootprintConstant.Storyboard.Main)
                    })
                }else{
                    self?.showAlert(title: FootprintConstant.Alert.Ops, message: message)
                }
                
                
            }else if responseCode == FootprintConstant.APIResponseCode.RegistrationError
            {
                self?.showAlert(title: FootprintConstant.Alert.Ops, message: message)
            }
        })
    }
    
    @IBAction fileprivate func registrationAction(){
        navigationController?.pushViewController(SignUpVC.instantiate(), animated: true)
    }
    
    @IBAction fileprivate func forgotPasswordAction() {
        navigationController?.pushViewController(ForgotPasswordVC.instantiate(), animated: true)
    }
    
}

/* ---------------------------------- Extension ----------------------------------------- */
//MARK:- Extension
extension LoginVC
{
    struct Storyboard{
        static let ControllerID = "LoginVC"
    }
    
    //MARK:- Static Method
    static func instantiate() -> LoginVC{
        let storyboard = UIStoryboard(name: FootprintConstant.Storyboard.Login, bundle: Bundle.main)
        return storyboard.instantiateViewController(withIdentifier: Storyboard.ControllerID) as! LoginVC
    }
    
}

