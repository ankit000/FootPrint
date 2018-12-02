//
//  MyAccountHelper.swift
//  Footprint
//
//  Created by Abhinay Maurya on 14/12/16.
//  Copyright © 2016 ONS. All rights reserved.
//

import Foundation

struct MyAccountRecord{
    let title:String!
}

enum MYAccountSection:Int{
    case Info = 0, Orders, RewardPoints, ChangePassword, GiftBalance, SignOut
}

final class MyAccountHelper
{
    static let dataSource = [
        MyAccountRecord(title: "Customer Info"),
        MyAccountRecord(title: "Orders"),
        MyAccountRecord(title: "Reward Points"),
        MyAccountRecord(title: "Change Password"),
        MyAccountRecord(title: "Gift Card Balance"),
        MyAccountRecord(title: "Sign Out")
    ]
}

