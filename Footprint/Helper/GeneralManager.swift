//
//  GeneralManager.swift
//  VSearch
//
//  Created by Abhinay Maurya on 06/10/16.
//  Copyright © 2016 ONS. All rights reserved.
//

import UIKit
import IQKeyboardManagerSwift

final class GeneralManager
{
    static let sharedInstance = GeneralManager()
    
    static func applicationInitialSetUp()
    {
        //#1
        IQKeyboardManager.shared.enable = true
        IQKeyboardManager.shared.shouldResignOnTouchOutside =  true
        IQKeyboardManager.shared.placeholderFont = UIFont(name: FootprintConstant.Font.Montserrat.Regular, size: 15.0)
        IQKeyboardManager.shared.previousNextDisplayMode = .alwaysHide
        
        //#2
        //If user has logged in once then save the last cookies which we got after registration/login
        if UserRecordHelper.sharedInstance.isLogin
        {
           // HTTPCookieStorage.shared.setCookie(UserRecordHelper.sharedInstance.cookie!)
        }
       // #3
        //DropDown.startListeningToKeyboard()
        
        //#4
        ApplicationAppearanceManager.appLoadingAppearance()
        setURLCacheCapacity()
    }
    
    fileprivate static func setURLCacheCapacity()
    {
        let memoryCapacity = 500 * 1024 * 1024
        let diskCapacity = 500 * 1024 * 1024
        let urlCache = URLCache(memoryCapacity: memoryCapacity, diskCapacity: diskCapacity, diskPath: "ImageCacheDemo")
        URLCache.shared = urlCache
        
    }
    
}
