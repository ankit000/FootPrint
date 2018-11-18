//
//  ApplicationAppearanceManager.swift
//  VSearch
//
//  Created by Abhinay Maurya on 16/10/16.
//  Copyright © 2016 ONS. All rights reserved.
//

import UIKit
//import SlideMenuControllerSwift
import SideMenu

class ApplicationAppearanceManager
{
    static func appLoadingAppearance()
    {
        SideMenuManager.default.menuAnimationBackgroundColor = FootprintConstant.Color.FootprintBlueColor
        SideMenuManager.default.menuWidth = UIScreen.main.bounds.size.width * 75 / 100
        
//        SlideMenuOptions.contentViewScale = 1.0
//        SlideMenuOptions.contentViewOpacity = 0.25
//        SlideMenuOptions.hideStatusBar = false
       
        let window = UIApplication.shared.windows.first
        window?.backgroundColor = FootprintConstant.Color.FootprintBlueColor
        
//        UINavigationBar.appearance().barTintColor = VoilaConstant.Color.Yellow
//        UINavigationBar.appearance().isTranslucent = false
//        UINavigationBar.appearance().tintColor = UIColor.white
//        UINavigationBar.appearance().titleTextAttributes = [NSFontAttributeName: UIFont(name: VoilaConstant.Font.Pertili.Light, size: 25)!,NSForegroundColorAttributeName:VoilaConstant.Color.Purple]
//        
//        UIBarButtonItem.appearance().setTitleTextAttributes([NSFontAttributeName: UIFont(name: VoilaConstant.Font.Pertili.Light, size: 15)!,NSForegroundColorAttributeName:VoilaConstant.Color.Purple], for: .normal)
    }
    
}
