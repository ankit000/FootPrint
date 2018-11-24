//
//  LoginNavVC.swift
//  Footprint
//
//  Created by Abhinay Maurya on 03/10/16.
//  Copyright © 2016 ONS. All rights reserved.
//

import UIKit

class LoginNavVC: UINavigationController
{
    
}

/* ---------------------------------- Extension ----------------------------------------- */
//MARK:- Extension
extension LoginNavVC
{
    struct Storyboard{
        static let ControllerID = "LoginVC"
    }
    
    //MARK:- Static Method
    static func instantiate() -> LoginVC{
        let storyboard = UIStoryboard(name: FootprintConstant.Storyboard.Main, bundle: Bundle.main)
        return storyboard.instantiateViewController(withIdentifier: Storyboard.ControllerID) as! LoginVC
    }
    
}
