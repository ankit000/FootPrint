//
//  RewardPointsVC.swift
//  Footprint
//
//  Created by Abhinay Maurya on 16/12/16.
//  Copyright © 2016 ONS. All rights reserved.
//

import UIKit

class RewardPointsVC: HeaderVC
{
    //MARK:- Private Vars
    let dataSourceLoyltyProgram = LoyaltyRecord()
    
    //MARK:- IBOutlet
    
    @IBOutlet fileprivate weak var lblAnswer2: UILabel!
    @IBOutlet fileprivate weak var lblAnswer1: UILabel!
    @IBOutlet fileprivate weak var lblQuestion2: UILabel!
    @IBOutlet fileprivate weak var lblQuestion1: UILabel!
    @IBOutlet fileprivate weak var lblCurrentBalance: UILabel!
    @IBOutlet fileprivate weak var lblMinPointsToRedeem: UILabel!
    
    //MARK:- View Life Cycle
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
    fileprivate func initialSetting()
    {
        pageTitle = "REWARD POINTS"
        
        lblAnswer1.text = dataSourceLoyltyProgram.answer1
        lblAnswer2.text = dataSourceLoyltyProgram.answer2
        lblQuestion1.text = dataSourceLoyltyProgram.question1
        lblQuestion2.text = dataSourceLoyltyProgram.question2
        
        self.loadPoints()
    }
    
    fileprivate func pageAppearance(){
        isHideBackgroundImage = true
        self.view.backgroundColor = FootprintConstant.Color.FootprintBlueColor
    }
    
    fileprivate func loadPoints(){
        showLoadIndicator(title: "Fetching...")
        RewardPointHelper.fetchRewardPoints {[weak self] (status, record) in
            if status == false || record == nil{
                self?.showAlert(title: FootprintConstant.Alert.Error, message: "Something went wrong!!")
            }else{
                self?.hideLoadIndicator()
                self?.lblCurrentBalance.text = "\(record!.rewardPointsBalance!) REWARD POINTS (\(record!.rewardPointsAmount!))"
                self?.lblMinPointsToRedeem.text = "\(record!.minimumRewardPointsToUse!) REWARD"
            }
            self?.hideLoadIndicator()
        }
    }

}

/* ---------------------------------- Extension ----------------------------------------- */
//MARK:- Extension
extension RewardPointsVC
{
    struct Storyboard
    {
        static let ControllerID = String(describing: RewardPointsVC.self)
        static let SegueID = "RewardPointsSegue"
    }
    
    
    //MARK:- Static Metod
    static func instantiate() -> RewardPointsVC{
        let storyboard = UIStoryboard(name: FootprintConstant.Storyboard.Main, bundle: Bundle.main)
        return storyboard.instantiateViewController(withIdentifier: Storyboard.ControllerID) as! RewardPointsVC
    }
    
}
