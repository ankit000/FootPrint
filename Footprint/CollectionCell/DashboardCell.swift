//
//  DashboardCell.swift
//  Footprint
//
//  Created by Abhinay Maurya on 08/10/16.
//  Copyright © 2016 ONS. All rights reserved.
//

import UIKit

class DashboardCell: UICollectionViewCell
{
    //MARK:- IBOutlets
    @IBOutlet fileprivate weak var lblTitle:UILabel!
    @IBOutlet fileprivate weak var imgBackGround:UIImageView!
    @IBOutlet fileprivate weak var lblLeftSeperator: UILabel!
    
    @IBOutlet fileprivate weak var widthConstraintRightSeperator: NSLayoutConstraint!
    @IBOutlet fileprivate weak var viewOverlay:UIView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    //MARK:- View Life Cycle
    override func awakeFromNib() {
        super.awakeFromNib()
        lblTitle.textColor = WhiteColor
        imgBackGround.layer.masksToBounds = true
        imgBackGround.contentMode = .scaleAspectFill
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        widthConstraintRightSeperator.constant = lblLeftSeperator.bounds.size.width
        
//        if let defaultImage = record?.defaultImage{
//            imgBackGround.image = UIImage(named: defaultImage)
//        }
    }
    
    //MARK:- Public Apis
    var record:DashboardRecord!
        {
        didSet{
            lblTitle.text = record.title
            lblTitle.font = UIFont(name: FootprintConstant.Font.Montserrat.Regular, size: 21)!
            
            if record.title == "PLUS" || record.title == "BLOG"
            {
                viewOverlay.alpha = 1
                viewOverlay.backgroundColor = FootprintConstant.Color.FootprintBlueColor
                activityIndicator.stopAnimating()
                
                let imageName = record.title == "PLUS" ? "Plus" : "Blog"
                imgBackGround.image = UIImage(named:imageName)
            }
            else{
                let urlString = record.thumbUrl!
                let url = URL(string: urlString)!
                
                URLSession.shared.dataTask(with: url, completionHandler: {[weak self] (data, response, error) in
                    DispatchQueue.main.async {
                        self?.activityIndicator.stopAnimating()
                    }
                    
                    if error != nil{
                        return
                    }else{
                        let image = UIImage(data: data!)
                        DispatchQueue.main.async {
                            self?.imgBackGround.image = image
                        }
                        
                    }
                }).resume()
            }
            
           widthConstraintRightSeperator.constant = lblLeftSeperator.bounds.size.width
           layoutIfNeeded()
           setNeedsUpdateConstraints()
        }
    }
    
    override func apply(_ layoutAttributes: UICollectionViewLayoutAttributes)
    {
        super.apply(layoutAttributes)
        
        let featuredHeight: CGFloat = Constant.featuredHeight
        let standardHeight: CGFloat = Constant.standardHegiht
        let delta = 1 - (featuredHeight - frame.height) / (featuredHeight - standardHeight)
        let minAlpha: CGFloat = Constant.minAlpha
        let maxAlpha: CGFloat = Constant.maxAlpha
        let alpha = maxAlpha - (delta * (maxAlpha - minAlpha))
        viewOverlay.alpha = alpha
//        let scale = max(delta, 0.5)
//        lblTitle.transform = CGAffineTransform(scaleX: scale, y: scale)
        
        // descriptionLabel.alpha = delta
    }
    
}

//MARK:- Extension
extension DashboardCell
{
    struct Storyboard {
        static let Identifier = String(describing:DashboardCell.self)
    }
    
    struct Constant {
        static let featuredHeight: CGFloat = 320
        static let standardHegiht: CGFloat = 100
        
        static let minAlpha: CGFloat = 0.0
        static let maxAlpha: CGFloat = 0.25
    }
    
    static func registerNib(collectionView:UICollectionView)
    {
        collectionView.register(UINib(nibName: Storyboard.Identifier, bundle: nil), forCellWithReuseIdentifier: Storyboard.Identifier)
    }
}

