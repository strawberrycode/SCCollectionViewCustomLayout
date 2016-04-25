//
//  TextCell.swift
//  SCCollectionViewCustomLayout
//
//  Created by Catherine Schwartz on 30/12/2015.
//  Copyright © 2015 Catherine Schwartz. All rights reserved.
//

import UIKit

class TextCell: UICollectionViewCell {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var textLabel: UILabel!
    
    
    override func awakeFromNib() {
        backgroundColor = UIColor.whiteColor()
    }
    
    
    override func preferredLayoutAttributesFittingAttributes(layoutAttributes: UICollectionViewLayoutAttributes) -> UICollectionViewLayoutAttributes {
        
        let attr = layoutAttributes.copy() as! UICollectionViewLayoutAttributes
        
        self.setNeedsLayout()
        self.layoutIfNeeded()
        
        let desiredHeight: CGFloat = self.contentView.systemLayoutSizeFittingSize(UILayoutFittingCompressedSize).height
        attr.frame.size.height = desiredHeight
        self.frame = attr.frame  // Do NOT forget to set the frame or the layout won't get it !!!
        
        return attr
    }

}
