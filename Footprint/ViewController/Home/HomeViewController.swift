//
//  HomeViewController.swift
//  Footprint
//
//  Created by Ankit Katiyar on 17/11/18.
//  Copyright © 2018 ONS. All rights reserved.
//

import UIKit

class HomeViewController: SuperContainerVC,UICollectionViewDataSource,UICollectionViewDelegate {
    
    //MARK:- IBOutlets
    @IBOutlet fileprivate weak var collectionView: UICollectionView!

    //MARK:- Private Variables

    let cellID = "galleryCellID"
    let cellID2 = "galleryCellID2"
    let defaultMinRatio = 2.5
    let defaultMaxRatio = 1.5
    private var currentStyle = ""
    private var menuOverlay: UIView?
    private var minRatioLabel: UILabel?
    private var minRatioSlider: UISlider?
    private var maxRatioLabel: UILabel?
    private var maxRatioSlider: UISlider?
    private var minRatio: CGFloat = 0.0
    private var maxRatio: CGFloat = 0.0
    private var exampleSwitch: UISegmentedControl?
    private var slidingLayout: AWCollectionViewSlidingDoorLayout?
    private var exampleIndex: Int = 0
    private var items = [[String:String]]()

    
    fileprivate let btnMenu:UIButton = {
        let btn = UIButton(type: .custom)
        btn.setTitleColor(.white, for: .normal)
        btn.titleLabel?.font = UIFont(name: FootprintConstant.Font.BlackTie.FamilyName, size: 17)
        
        return btn
    }()
    
    // MARK: Life Cycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        currentStyle = "style1"
        
        let jsonPath = Bundle.main.path(forResource: "gallery", ofType: "json")
        let jsonData: Data? = FileManager.default.contents(atPath: jsonPath ?? "")
        if let aData = jsonData {
            items = try! JSONSerialization.jsonObject(with: aData, options: []) as! [[String : String]]
        }
        
        minRatio = CGFloat(defaultMinRatio)
        maxRatio = CGFloat(defaultMaxRatio)
        exampleIndex = 0
        
        collectionView.register(UINib(nibName: "galleryCell", bundle: Bundle.main), forCellWithReuseIdentifier: cellID)
        collectionView.register(UINib(nibName: "galleryCell2", bundle: Bundle.main), forCellWithReuseIdentifier: cellID2)
        slidingLayout = AWCollectionViewSlidingDoorLayout(maxRatio: CGFloat(defaultMaxRatio), andMinRatio: CGFloat(defaultMinRatio))
        if let aLayout = slidingLayout {
            collectionView.collectionViewLayout = aLayout
        }
        collectionView.collectionViewLayout.invalidateLayout()
        
        perform(#selector(HomeViewController.quickFix), with: nil, afterDelay: 0.01)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
    }
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(true)
    }
    
    
    @objc func quickFix() {
        collectionView.contentOffset = CGPoint(x: 0, y: collectionView.contentOffset.y + 1)
    }
    
    func layoutSubviews(withAttributes theAttributes: [AnyHashable]?) {
        let theAttributes = theAttributes
        for i in 0..<(theAttributes?.count ?? 0) {
            let cell = collectionView.cellForItem(at: IndexPath(row: i, section: 0)) as? GalleryCell
            
            let maxHeight: CGFloat = (collectionView?.bounds.size.width ?? 0.0) / maxRatio
            let minHeight: CGFloat = (collectionView?.bounds.size.width ?? 0.0) / minRatio
            let cellHeight: CGFloat = maxHeight * 0.5 + minHeight * 0.5
            let currentIndex: Int = Int((collectionView?.contentOffset.y ?? 0.0) / cellHeight)
            
            let ratio = (cell?.bounds.size.width)! / (cell?.bounds.size.height)!
            let maxDiff: CGFloat = minRatio - maxRatio
            let diff: CGFloat = minRatio - ratio
            
            let alpha: CGFloat = diff / maxDiff
            
            
            if exampleIndex == 0 {
                cell?.overlayView.alpha = 1 - alpha
                cell?.titleLabel.alpha = alpha
            } else {
                cell?.overlayView.alpha = 1 - alpha
                cell?.titleLabel.alpha = alpha
                cell?.subtitleLabel.alpha = alpha
                if i > currentIndex {
                    cell?.titleLabel.transform = CGAffineTransform(scaleX: 1 - (1 - alpha) * 0.3, y: 1 - (1 - alpha) * 0.3)
                    cell?.subtitleLabel.transform = CGAffineTransform(translationX: 0, y: (1 - alpha) * 30)
                } else {
                    cell?.titleLabel.transform = CGAffineTransform.identity
                    cell?.subtitleLabel.transform = CGAffineTransform.identity
                }
            }
        }
    }

    
    
    
    func collectionView(_ cv: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let itemDict = items[indexPath.item]
        
        var cell: GalleryCell?
        if exampleIndex == 0 {
            cell = cv.dequeueReusableCell(withReuseIdentifier: cellID, for: indexPath) as? GalleryCell
        } else {
            cell = cv.dequeueReusableCell(withReuseIdentifier: cellID2, for: indexPath) as? GalleryCell
        }
        
        cell?.titleLabel.text = itemDict["title"]?.uppercased()
       // cell?.subtitleLabel.text = itemDict["subtitle"]
        cell?.imageView.image = UIImage(named: itemDict["image"] ?? "")
        
        return cell!
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    }
    
    //MARK:-
    override var prefersStatusBarHidden: Bool{
        return true
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

/* ---------------------------------- Extension ----------------------------------------- */
//MARK:- Extension
extension HomeViewController
{
    struct Storyboard{
        static let ControllerID = "HomeViewController"
    }
    
    //MARK:- Static Method
    static func instantiate() -> HomeViewController{
        let storyboard = UIStoryboard(name: FootprintConstant.Storyboard.Main, bundle: Bundle.main)
        return storyboard.instantiateViewController(withIdentifier: Storyboard.ControllerID) as! HomeViewController
    }
    
}
