//
//  LeftMenuVC.swift
//  Footprint
//
//  Created by Abhinay on 30/08/18.
//  Copyright © 2018 ONS. All rights reserved.
//

import UIKit

enum MenuSection:String{
    case Logout
}

struct MenuRecord {
    let title:String!
    let imageName:String!
}

class LeftMenuVC:UICollectionViewController, UICollectionViewDelegateFlowLayout
{
    
    //MARK:- Priavte Constant
    fileprivate let cellId = "MenuCell"
    
    //MARK:- Priavte Vars
    fileprivate var dataSource = [MenuRecord]()
    
    //MARK:- Widget
    fileprivate let headerImage:UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.image = #imageLiteral(resourceName: "footprintHeader")
        imageView.layer.masksToBounds = true
        return imageView
    }()
    
    //MARK:- View Life Cycle
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
//        SideMenuManager.default.menuAddPanGestureToPresent(toView: self.navigationController!.navigationBar)
//        SideMenuManager.default.menuAddScreenEdgePanGesturesToPresent(toView: self.navigationController!.view)
        
        initialSetting()
        pageAppearance()
    }
    
    //MARK:- Private Methods
    fileprivate func initialSetting()
    {
        view.addSubview(headerImage)
        
        setData()
        setLayout()
        collectionView?.register(MenuCell.self, forCellWithReuseIdentifier: cellId)
    }
    
    fileprivate func pageAppearance(){
        navigationController?.navigationBar.isHidden = true
        collectionView?.backgroundColor = FootprintConstant.Color.FootprintBlueColor
    }
    
    fileprivate func setLayout()
    {
        headerImage.widthAnchor.constraint(equalTo: headerImage.heightAnchor, multiplier: 8/3, constant: 0).isActive = true
        headerImage.widthAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.32, constant: 0).isActive = true
        headerImage.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        let topAnchor = self.statusBarHeight() + 48.0
        
        view.addConstraint(visualFormat: "H:|[v0]|", forViews: collectionView!)
        view.addConstraint(visualFormat: "V:|-\(topAnchor)-[v0]-30-[v1]|", forViews: headerImage, collectionView!)
    }
    
    fileprivate func setData()
    {
        dataSource.append(MenuRecord(title:"Home", imageName:""))
        dataSource.append(MenuRecord(title:"My Journey", imageName:""))
        dataSource.append(MenuRecord(title:"Gift", imageName:""))
        dataSource.append(MenuRecord(title:"Blog", imageName:""))
        dataSource.append(MenuRecord(title:"My Account", imageName:""))
        dataSource.append(MenuRecord(title:"Loyalty Program", imageName:""))
        dataSource.append(MenuRecord(title:"Shoe Rack", imageName:""))
        dataSource.append(MenuRecord(title:"Logout", imageName:""))
    }
    
    //MARK:- Collection DataSource
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
    {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! MenuCell
        cell.record = dataSource[indexPath.item]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.size.width, height: 54)
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath)
    {
        if let section = MenuSection(rawValue: dataSource[indexPath.item].title){
            switch section
            {
            case .Logout:
                UserRecordHelper.sharedInstance.logout()
                openStoryboard(name: FootprintConstant.Storyboard.Login)
            }
            
        }
        
    }
}

extension LeftMenuVC
{
    static func instantiate() -> LeftMenuVC
    {
        let flowLayout = UICollectionViewFlowLayout()
        let vc = LeftMenuVC(collectionViewLayout: flowLayout)
        return vc
    }
}


//MARK:- UICollectionViewCell

class MenuBaseCell:UICollectionViewCell
{
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    fileprivate func setupView(){
        
    }
}

class MenuCell: MenuBaseCell
{
    private var datePicker:UIDatePicker?
    
    var record:MenuRecord!{
        didSet{
            lblTitle.text = record.title
            lblImage.text = record.imageName
        }
    }
    
    private let lblTitle:UILabel = {
        let lbl = UILabel()
        lbl.font = UIFont.systemFont(ofSize: 24.0)
        lbl.textColor = .white
        return lbl
    }()
    
    private let lblImage:UILabel = {
        let lbl = UILabel()
        lbl.font = UIFont(name: FootprintConstant.Font.BlackTie.Solid, size: 24)
        lbl.textColor = .white
        return lbl
    }()
    
    private let seperatorView:UIView = {
        let view = UIView()
        view.backgroundColor = .white
        return view
    }()
   
    override func setupView()
    {
        addSubview(lblTitle)
        addSubview(lblImage)
        addSubview(seperatorView)
        
        setLayout()
    }
    
    private func setLayout(){
        addConstraint(visualFormat: "H:|-15-[v0]-15-[v1]-15-|", forViews: lblTitle, lblImage)
        addConstraint(visualFormat: "H:|-15-[v0]|", forViews: seperatorView)
        
        addConstraint(visualFormat: "V:|-5-[v0]-5-|", forViews: lblTitle)
        addConstraint(visualFormat: "V:|-5-[v0]-5-|", forViews: lblImage)
        addConstraint(visualFormat: "V:[v0(0.50)]|", forViews: seperatorView)
    }
}

