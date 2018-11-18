//
//  Date+Utility.swift
//  Footprint
//
//  Created by Abhinay Maurya on 15/12/16.
//  Copyright © 2016 ONS. All rights reserved.
//

import Foundation

extension Date
{
    func string() -> String
    {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE MMMM dd, yyyy"
        return dateFormatter.string(from: self)
    }
    
    func stringInServerFormat() -> String
    {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd-MM-yy"
        return dateFormatter.string(from: self)
    }
    
    func stringInNormalFormat() -> String
    {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yy"
        return dateFormatter.string(from: self)
    }
    
    func shortString() -> String
    {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .short
        return dateFormatter.string(from: self)
    }
    
    func mediumString() -> String
    {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        return dateFormatter.string(from: self)
    }

}
