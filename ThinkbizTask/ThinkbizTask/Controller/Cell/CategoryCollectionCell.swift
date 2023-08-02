//
//  CategoryCollectionCell.swift
//  TestiTuneDemo
//
//  Created by Apple on 02/08/23.
//

import UIKit

class CategoryCollectionCell: UICollectionViewCell {
    
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var imgPicture: UIImageView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func populate(objData: Data) {
        lblTitle.text = objData.subcategoryName
        if let imgUrl = objData.url {
            ApiHandlerClass.shared().downloadImage(imgUrl) { image, urlString in
                if let imageObject = image {
                    DispatchQueue.main.async {
                        self.imgPicture.image = imageObject
                    }
                }
            }
        }
    }
    
}
