//
//  UIView+Utility.swift
//  Interview
//
//  Created by Abhinay Maurya on 10/10/16.
//  Copyright © 2016 ONS. All rights reserved.
//

import UIKit


extension UIView
{
    func drawBorder(cornerRadius cr:CGFloat, borderWidth bw:CGFloat, borderColor bc:UIColor, maskToBound mtb:Bool){
        self.layer.cornerRadius = cr
        self.layer.borderWidth = bw
        self.layer.borderColor = bc.cgColor
        self.layer.masksToBounds = mtb
    }
    
    func drawShadow (offset ofset:CGSize, shadowRadius sr:CGFloat, shadowColor sc:UIColor, shadowOpacity so:Float, masksToBounds mb:Bool)
    {
        self.layer.shadowOffset = ofset
        self.layer.shadowRadius = sr
        self.layer.shadowColor = sc.cgColor
        self.layer.shadowOpacity = so
        self.layer.masksToBounds = mb
    }

    
    
}

//Extension----
extension UIView
{
    func addConstraint(visualFormat format:String, forViews: UIView...)
    {
        var dict = [String:UIView]()
        for (index, view) in forViews.enumerated()
        {
            let key = "v\(index)"
            view.translatesAutoresizingMaskIntoConstraints = false
            dict[key] = view
        }
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: format, options: [], metrics: nil, views: dict))
    }
}
