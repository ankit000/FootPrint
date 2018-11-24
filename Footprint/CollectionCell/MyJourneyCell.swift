//
//  MyJourneyCell.swift
//  Footprint
//
//  Created by Abhinay Maurya on 10/12/16.
//  Copyright © 2016 ONS. All rights reserved.
//

import UIKit

class MyJourneyCell: UICollectionViewCell
{
    //MARK:- IBOutlet
    @IBOutlet private weak var lblTitle: UILabel!
    @IBOutlet private weak var lblSubTitle: UILabel!
    @IBOutlet private weak var lblOnlyTitle: UILabel!
    @IBOutlet private weak var stackView: UIStackView!
    
    //MARK:- Public Var
    var data:[String:String]!
    {
        didSet{
            if data["subtitle"] == ""
            {
                lblOnlyTitle.text = data["title"]?.uppercased()
                stackView.isHidden = true
                lblOnlyTitle.isHidden = false
            }else{
                lblTitle.text = data["title"]?.uppercased()
                lblSubTitle.text = data["subtitle"]?.uppercased()
                stackView.isHidden = false
                lblOnlyTitle.isHidden = true
            }
        }
    }
    
    //MARK;- Cell Life Cycle
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    

}
/* ------------------------------ extension -------------------------- */
extension MyJourneyCell
{
    struct Constant
    {
        static let Identifier = "MyJourneyCell"
    }
    
    static func registerNib (collectionView:UICollectionView){
        collectionView.register(UINib(nibName: Constant.Identifier, bundle: nil), forCellWithReuseIdentifier: Constant.Identifier)
    }
}
