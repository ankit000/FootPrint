//
//  LoyaltyProgramHelper.swift
//  Footprint
//
//  Created by Abhinay Maurya on 16/12/16.
//  Copyright © 2016 ONS. All rights reserved.
//

import Foundation

struct LoyaltyRecord
{
    let title:String = "FOOTPRINT REWARD POINTS ARE A WAY TO SAY THANK YOU FOR PURCHASING OUR SHOES AND HELPING SPREAD THE WORLD ABOUT US. IT CAN BE REDEEMED FOR SAVINGS ON FUTURE PURCHASES."
   
    let membershipPoint = 500
    let sharingPoint    = 300
    let reviewsPoint    = 150
    let referAFriend    = 150
    let purchasePoint   = 1
    let minSpendingCost = 10
    
    let question1 = "HOW POINTS CAN BE USED?"
    let answer1 = "ON CHECKOUT PAGE YOU WILL HAVE AN OPTION TO REDEEM YOUR POINTS. CLICK ON IT ANDYOU WILL GET YOUR DISCOUNT."
    
    let question2 = "DO POINTS EXPIRE?"
    let answer2 = "YES, IF YOU DON'T REDEEM POINTS IN 12 MONTHS THEN IT WILL EXPIRE."
    
    let minimumPointsToRedeem = 15000
    let queryEmail = "INFO@FOOTPRINT.com"
}

