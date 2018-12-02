//
//  LoyaltyProgramVC.swift
//  Footprint
//
//  Created by Abhinay Maurya on 16/12/16.
//  Copyright © 2016 ONS. All rights reserved.
//

import UIKit

class LoyaltyProgramVC: HeaderVC
{
    //MARK:- Private Vars
    let dataSource = LoyaltyRecord()
    
    //MARK:- IBOutlet
    @IBOutlet fileprivate weak var lblAboutLoyalty: UILabel!
    @IBOutlet fileprivate weak var scrollView: UIScrollView!
    @IBOutlet fileprivate weak var lblReviewPoints: UILabel!
    @IBOutlet fileprivate weak var lblMembershipPoints: UILabel!
    @IBOutlet fileprivate weak var lblSharingPoints: UILabel!
    @IBOutlet fileprivate weak var lblReferAFriendPoints: UILabel!
    @IBOutlet fileprivate weak var lblSpendPoints: UILabel!
    @IBOutlet fileprivate weak var lblQuestion1: UILabel!
    @IBOutlet fileprivate weak var lblAnswer1: UILabel!
    @IBOutlet fileprivate weak var lblQuestion2: UILabel!
    @IBOutlet fileprivate weak var lblAnswer2: UILabel!
    @IBOutlet fileprivate weak var lblEmail: UILabel!
    
    //MARK:- ViewC Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        initialSetting()
        pageAppearance()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    //MARK:- Private Methods
    fileprivate func initialSetting()
    {
        pageTitle = "LOYALTY PROGRAM"
        lblEmail.text = "EMAIL US AT \(dataSource.queryEmail)"
        lblQuestion1.text = dataSource.question1
        lblQuestion2.text = dataSource.question2
        lblAnswer1.text = dataSource.answer1
        lblAnswer2.text = dataSource.answer2
        lblAboutLoyalty.text = dataSource.title
        lblSpendPoints.text = "\(dataSource.purchasePoint)"
        lblMembershipPoints.text = "\(dataSource.sharingPoint) POINTS"
        lblReviewPoints.text = "\(dataSource.reviewsPoint) POINTS"
        lblReferAFriendPoints.text = "\(dataSource.referAFriend) POINTS"
        lblSharingPoints.text = "\(dataSource.referAFriend) POINTS"
    }
    
    fileprivate func pageAppearance(){
        isHideBackgroundImage = true
        scrollView.contentSize = CGSize(width: scrollView.frame.size.width, height: 6600.0)
    }
    

}

/* ---------------------------------- Extension ----------------------------------------- */
//MARK:- Extension
extension LoyaltyProgramVC
{
    struct Storyboard{
        static let ControllerID = String(describing: LoyaltyProgramVC.self)
    }
    
    //MARK:- Static Metod
    static func instantiate() -> LoyaltyProgramVC{
        let controller = LoyaltyProgramVC(nibName: "LoyaltyProgramVC", bundle: nil)
        return controller
    }
}
   
