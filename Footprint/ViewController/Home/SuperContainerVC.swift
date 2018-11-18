//
//  SuperContainerVC.swift
//  Footprint
//
//  Created by Abhinay Maurya on 18/10/16.
//  Copyright © 2016 ONS. All rights reserved.
//

import UIKit

class SuperContainerVC: UIViewController
{
    //MARK:- Public Vars
  
    
    var isWhiteBackgroundEnabled = false{
        didSet{
            if isWhiteBackgroundEnabled == true{
                view.backgroundColor = UIColor.white
                btnMenu.setTitleColor(FootprintConstant.Color.FootprintBlueColor, for: .normal)
            }
        }
    }
    
    //MARK:- Private Widget
    fileprivate let viewHeader:UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        return view
    }()
    
    fileprivate let btnMenu:UIButton = {
        let btn = UIButton(type: .custom)
        btn.setTitleColor(.white, for: .normal)
        btn.titleLabel?.font = UIFont(name: FootprintConstant.Font.BlackTie.FamilyName, size: 17)
        
        return btn
    }()
    
    fileprivate let bgImage:UIView = {
        let imageV = UIImageView()
        imageV.layer.masksToBounds = true
        imageV.image = #imageLiteral(resourceName: "BG")
        return imageV
    }()
    
    
    //MARK:- Life Cycle
    override func viewDidLoad()
    {
        super.viewDidLoad()
        pageAppearance()
        initialSetting()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK:- Private Apis
    
    fileprivate func pageAppearance (){
        view.backgroundColor = FootprintConstant.Color.FootprintBlueColor
    }
    
    fileprivate func initialSetting ()
    {
        view.addSubview(bgImage)
        view.addSubview(viewHeader)
        view.addSubview(btnMenu)
        view.sendSubview(toBack: bgImage)
        
        setCommonLayout()
        
        btnMenu.addTarget(self, action: #selector(SuperContainerVC.openLeftMenu), for: .touchUpInside)
//        if (self.navigationController?.viewControllers.count)! > 1 {
//            btnMenu.setTitle(FootprintConstant.Font.BlackTie.Text.Back, for: .normal)
//        }else{
            btnMenu.setTitle(FootprintConstant.Font.BlackTie.Text.ThreeLine, for: .normal)
       // }
        
    }
    
    func setCommonLayout()
    {
        let topAnchor = self.statusBarHeight() + 5.0
        
        view.addConstraint(visualFormat: "H:|[v0]|", forViews: viewHeader)
        view.addConstraint(visualFormat: "V:|[v0(44)]", forViews: viewHeader)
        
        view.addConstraint(visualFormat: "H:|-15-[v0(30)]", forViews: btnMenu)
        view.addConstraint(visualFormat: "V:|-\(topAnchor)-[v0(30)]", forViews: btnMenu)
        
        view.addConstraint(visualFormat: "H:|[v0]|", forViews: bgImage)
        view.addConstraint(visualFormat: "V:|[v0]|", forViews: bgImage)
    }
    
    //MARK:-
    @objc fileprivate func openLeftMenu()
    {
//        if (self.navigationController?.viewControllers.count)! > 1 {
//            let _ = self.navigationController?.popViewController(animated: true)
//        }else{
            present(LeftMenuNVC.shared, animated: true, completion: nil)
        //}
        
    }
    
}
