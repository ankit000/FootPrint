//
//  LeftMenuNVC.swift
//  Footprint
//
//  Created by Abhinay on 30/08/18.
//  Copyright © 2018 ONS. All rights reserved.
//

import UIKit
import SideMenu

final class LeftMenuNVC:UISideMenuNavigationController
{
    static let shared = LeftMenuNVC.instantiate()
    
    static func instantiate() -> LeftMenuNVC
    {
        let rootVC = LeftMenuVC.instantiate()
        
        let menuLeftNavigationController = LeftMenuNVC(rootViewController: rootVC)
        SideMenuManager.default.menuLeftNavigationController = menuLeftNavigationController
        
        return menuLeftNavigationController
    }
}

