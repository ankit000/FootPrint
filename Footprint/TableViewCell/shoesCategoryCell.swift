//
//  shoesCategoryCell.swift
//  Footprint
//
//  Created by Ankit katiyar on 23/11/18.
//  Copyright © 2018 Ankit katiyar. All rights reserved.
//

import UIKit
import SDWebImage

class shoesCategoryCell: UITableViewCell {

    @IBOutlet weak var lblCategoryName:UILabel!
    @IBOutlet weak var imgCategory:UIImageView!

    
    // Set Data
    func setData(category:ShoesCategory) {
        
        self.lblCategoryName.text = category.title
        
        if (category.thumbUrl?.count)! > 0 {
            
            
            imgCategory?.sd_setImage(with: URL(string: (category.thumbUrl?.replacingOccurrences(of: " ", with: "+", options: .literal, range: nil))!)!, placeholderImage: nil,options: SDWebImageOptions(rawValue: 0), completed: { (image, error, cacheType, imageURL) in
                
                if(image != nil){
                    //self.imgCategory.image = self.resizeImage(image: image!, targetSize: CGSize(width: self.bounds.width, height: self.bounds.height))
                    self.imgCategory.image = image
                    self.imgCategory.contentMode = .scaleAspectFill
                }
            })
        }
    
    }
    
    func resizeImage(image: UIImage, targetSize: CGSize) -> UIImage {
        let size = image.size
        
        let widthRatio  = targetSize.width  / image.size.width
        let heightRatio = targetSize.height / image.size.height
        
        // Figure out what our orientation is, and use that to form the rectangle
        var newSize: CGSize
        if(widthRatio > heightRatio) {
            newSize = CGSize(width: size.width * heightRatio, height: size.height * heightRatio)
        } else {
            newSize = CGSize(width: size.width * widthRatio,  height: size.height * widthRatio)
        }
        
        // This is the rect that we've calculated out and this is what is actually used below
        let rect = CGRect(x: 0, y: 0, width: newSize.width, height: newSize.height)
        
        // Actually do the resizing to the rect using the ImageContext stuff
        UIGraphicsBeginImageContextWithOptions(newSize, false, 1.0)
        image.draw(in: rect)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        //imageheight.constant = newImage!.size.height
        return newImage!
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
