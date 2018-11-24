//
//  MyJourneyCellLayout.swift
//  Footprint
//
//  Created by Abhinay Maurya on 10/12/16.
//  Copyright © 2016 ONS. All rights reserved.
//

import UIKit

class MyJourneyCellLayout: UICollectionViewFlowLayout
{
    //MARK:- Private
    fileprivate var totalColumns = MyJourneyHelper.dataSource.myWork.count
    fileprivate let gap:CGFloat = 5
    // here we define the width of each cell, creating a 2 column layout. In case you would create 3 columns, change the number 2 to 3
    fileprivate var itemWidth:CGFloat!{
        get{
            return (collectionView!.frame.width/(CGFloat(self.totalColumns)) - gap)
        }
    }
    
    // here you can define the height of each cell
    fileprivate var itemHeight:CGFloat!{
        get{
            return itemWidth
        }
    }
    
    override init() {
        super.init()
        setupLayout()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupLayout()
    }
    
    /**
     Sets up the layout for the collectionView. 1pt distance between each cell and 1pt distance between each row plus use a vertical layout
     */
    func setupLayout() {
        minimumInteritemSpacing = gap
        minimumLineSpacing = gap
        scrollDirection = .vertical
    }
    
    override var itemSize: CGSize {
        set {
            self.itemSize = CGSize(width: itemWidth, height: itemHeight)
        }
        get {
            return CGSize(width:itemWidth, height: itemHeight)
        }
    }
    
    override func targetContentOffset(forProposedContentOffset proposedContentOffset: CGPoint) -> CGPoint {
        return collectionView!.contentOffset
    }
    
    
    
}
