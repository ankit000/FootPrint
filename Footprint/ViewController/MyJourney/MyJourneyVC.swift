//
//  MyJourneyVC.swift
//  Footprint
//
//  Created by Abhinay Maurya on 09/12/16.
//  Copyright © 2016 ONS. All rights reserved.
//

import UIKit

class MyJourneyVC: HeaderVC
{
    //MARK:- IBOutlet    
    @IBOutlet fileprivate weak var scrollView: UIScrollView!
    @IBOutlet fileprivate weak var lblSubTitle: UILabel!
    @IBOutlet fileprivate weak var lblTitle: UILabel!
    @IBOutlet fileprivate weak var imgHeader: UIImageView!
    
    @IBOutlet fileprivate weak var heightConstraintCollectionView: NSLayoutConstraint!
    @IBOutlet fileprivate weak var heightConstraintTextSection2View: NSLayoutConstraint!
    @IBOutlet fileprivate weak var heightConstraintTextSection1View: NSLayoutConstraint!
    @IBOutlet fileprivate weak var heightConstraintContainerView: NSLayoutConstraint!
   
    @IBOutlet fileprivate weak var lblSection1: UILabel!
    @IBOutlet fileprivate weak var txtSection1: UITextView!
    @IBOutlet fileprivate weak var lblSection2: UILabel!
    @IBOutlet fileprivate weak var txtSection2: UITextView!
    @IBOutlet fileprivate weak var collectionView: UICollectionView!
    
    //MARK:- Private Vars
    fileprivate var dataSource = MyJourneyHelper.dataSource
    
    //MARK:- ViewC Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        initialSetting()
        pageAppearance()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK:- Private Methods
    fileprivate func initialSetting()
    {
        pageTitle = "MY JOURNEY"
        collectionView.dataSource = self
        collectionView.delegate = self
        
        MyJourneyCell.registerNib(collectionView: collectionView)
        
        lblTitle.text = dataSource.title.uppercased()
        lblSubTitle.text = dataSource.subTitle.uppercased()
        if let image = UIImage(named: dataSource.imageURL!){
            imgHeader.image = image
        }
        
        lblSection1.text = dataSource.section1[MyJourneyHelper.Key.Question]?.uppercased()
        lblSection2.text = dataSource.section2[MyJourneyHelper.Key.Question]?.uppercased()
        
        txtSection1.text = dataSource.section1[MyJourneyHelper.Key.Description]
        txtSection2.text = dataSource.section2[MyJourneyHelper.Key.Description]
        
        let font = UIFont(name: FootprintConstant.Font.Montserrat.Regular, size: 14.0)
        
        print(txtSection1.bounds.size.width)
        
        let startingHeightOfDescription1 = heightConstraintTextSection1View.constant
        let newHeightOfDescription1 = (dataSource.section1[MyJourneyHelper.Key.Description]?.heightWithConstrainedWidth(width: txtSection1.bounds.size.width, font: font!))! + 50
        heightConstraintTextSection1View.constant = newHeightOfDescription1
        
        let startingHeightOfDescription2 = heightConstraintTextSection2View.constant
        let newHeightOfDescription2 = (dataSource.section2[MyJourneyHelper.Key.Description]?.heightWithConstrainedWidth(width: txtSection2.bounds.size.width, font: font!))! + 50
        heightConstraintTextSection2View.constant = newHeightOfDescription2
        
        heightConstraintContainerView.constant = heightConstraintContainerView.constant - startingHeightOfDescription1 + newHeightOfDescription1 - startingHeightOfDescription2 + newHeightOfDescription2 + 60
        scrollView.contentSize = CGSize(width: scrollView.frame.size.width, height: heightConstraintContainerView.constant)
    }
    
    fileprivate func pageAppearance(){
        isHideBackgroundImage = true
    }

}

/* ---------------------------------- Extension ----------------------------------------- */
//MARK:- Extension
extension MyJourneyVC
{
    struct Storyboard{
        static let ControllerID = String(describing: MyJourneyVC.self)
    }
    
  
    
    //MARK:- Static Metod
    static func instantiate() -> MyJourneyVC{
        let controller = MyJourneyVC(nibName: "MyJourneyVC", bundle: nil)
        return controller
    }
    
}

extension MyJourneyVC:UICollectionViewDataSource
{
    func numberOfSections(in collectionView: UICollectionView) -> Int
    {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
    {
        return dataSource.myWork.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
    {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MyJourneyCell.Constant.Identifier, for: indexPath) as! MyJourneyCell
        cell.data = dataSource.myWork[indexPath.row]
        
        return cell
    }
}

extension MyJourneyVC:UICollectionViewDelegate
{
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath)
    {
    }
}
