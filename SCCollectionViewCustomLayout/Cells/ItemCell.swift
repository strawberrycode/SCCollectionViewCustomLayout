//
//  ItemCell.swift
//  SCCollectionViewCustomLayout
//
//  Created by Catherine Schwartz on 30/12/2015.
//  Copyright © 2015 Catherine Schwartz. All rights reserved.
//

import UIKit

class ItemCell: UICollectionViewCell {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var itemLabel: UILabel!
 
    override func awakeFromNib() {
        setBorder(UIColor.redColor())
    }
    
    override func preferredLayoutAttributesFittingAttributes(layoutAttributes: UICollectionViewLayoutAttributes) -> UICollectionViewLayoutAttributes {
        
        let attr = layoutAttributes.copy() as! UICollectionViewLayoutAttributes
        self.setNeedsLayout()
        self.layoutIfNeeded()
        self.frame = attr.frame
        
        return attr
    }
}
