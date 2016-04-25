//
//  HeaderView.swift
//  SCCollectionViewCustomLayout
//
//  Created by Catherine Schwartz on 17/04/2016.
//  Copyright © 2016 Catherine Schwartz. All rights reserved.
//

import UIKit

class HeaderView: UICollectionReusableView {

    @IBOutlet var headerTitle: UILabel!
    @IBOutlet var headerText: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    
    override func preferredLayoutAttributesFittingAttributes(layoutAttributes: UICollectionViewLayoutAttributes) -> UICollectionViewLayoutAttributes {
        
        let attr = layoutAttributes.copy() as! UICollectionViewLayoutAttributes
        
        self.setNeedsLayout()
        self.layoutIfNeeded()
        
        let desiredHeight: CGFloat = self.systemLayoutSizeFittingSize(UILayoutFittingCompressedSize).height
        attr.frame.size.height = desiredHeight
        self.frame = attr.frame  // Do NOT forget to set the frame or the layout won't get it !!!
        
        return attr
    }
}
