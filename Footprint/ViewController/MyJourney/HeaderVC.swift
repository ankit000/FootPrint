//
//  HeaderVC.swift
//  Footprint
//
//  Created by Abhinay Maurya on 03/12/16.
//  Copyright © 2016 ONS. All rights reserved.
//

import UIKit

class HeaderVC: UIViewController
{
    //MARK:- Private methods
    @IBOutlet var viewHeader: UIView!
    
    //MARK:- Private Var
    fileprivate var lblTitle:UILabel!
    fileprivate let btnGoBack = UIButton(type: .custom)
    fileprivate let bgImage = UIImageView()
    
    //MARK:- Public Var
    var pageTitle:String!{
        didSet{
            lblTitle.text = pageTitle
        }
    }
    
    var isHideBackButton = false{
        didSet{
            btnGoBack.isHidden = isHideBackButton
        }
    }
    
    var isHideBackgroundImage = false{
        didSet{
            bgImage.isHidden = isHideBackgroundImage
        }
    }
    
    var headerBGColor:UIColor = Constant.GrayColor{
        didSet{
            viewHeader.backgroundColor = headerBGColor
        }
    }
    
    var tintColor = WhiteColor{
        didSet{
            lblTitle.textColor = tintColor
            btnGoBack.setTitleColor(tintColor, for: .normal)
        }
    }
    
    //MARK:- View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        pageAppearance()
        superInitialSetting()
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        lblTitle.frame = CGRect(x: 70, y: 0, width: viewHeader.frame.size.width - (70 * 2), height: viewHeader.frame.size.height)
    }
    
    
    //MARK:- Private Methods
    fileprivate func pageAppearance(){
        viewHeader.backgroundColor = Constant.GrayColor
        view.backgroundColor = Constant.GrayColor
    }
    
    fileprivate func  superInitialSetting(){
        addHeaderBarTools()
        addBGImage()
    }
    
    fileprivate func addHeaderBarTools ()
    {
        
        btnGoBack.addTarget(self, action: #selector(HeaderVC.goBack), for: .touchUpInside)
        btnGoBack.frame = CGRect(x: 5, y: 7, width: 30, height: 30)
        btnGoBack.setTitleColor(FootprintConstant.Color.FootprintBlueColor, for: .normal)
        
        if navigationController?.viewControllers.count == 1{
            btnGoBack.setTitle(FootprintConstant.Font.BlackTie.Text.ThreeLine, for: .normal)
        }else{
            btnGoBack.setTitle(FootprintConstant.Font.BlackTie.Text.Back, for: .normal)
        }
        
        
        btnGoBack.titleLabel?.font = UIFont(name: FootprintConstant.Font.BlackTie.Regular, size: 17)
        viewHeader.addSubview(btnGoBack)
        
        lblTitle = UILabel(frame: CGRect(x: 70, y: 0, width: viewHeader.frame.size.width - (70 * 2), height: viewHeader.frame.size.height))
        lblTitle.textColor = FootprintConstant.Color.FootprintBlueColor
        lblTitle.backgroundColor = ClearColor
        lblTitle.textAlignment = .center
        lblTitle.adjustsFontSizeToFitWidth = true
        lblTitle.font = UIFont(name: FootprintConstant.Font.Montserrat.Regular, size: 22.0)
        viewHeader.addSubview(lblTitle)
        
    }
    
    fileprivate func addBGImage(){
        bgImage.frame = view.frame
        bgImage.image = UIImage(named: "BG")
        view.addSubview(bgImage)
        view.sendSubview(toBack: bgImage)
    }

    
    //MARK:-
    @objc fileprivate func goBack()
    {
        if self.navigationController == nil
        {
            self.dismiss(animated: true, completion: nil)
        }
        else{
            let _ = navigationController?.popViewController(animated: true)
        }
        
    }
    
}

/* ---------------------------------- Extension ----------------------------------------- */
//MARK:- Extension
extension HeaderVC
{
    struct Constant {
        static let GrayColor = UIColor(red: 241.0/255.0, green: 241.0/255.0, blue: 241.0/255.0, alpha: 1.0)
    }
    
}
