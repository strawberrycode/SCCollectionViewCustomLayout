//
//  MyCollectionViewFlowLayout.swift
//  SCCollectionViewCustomLayout
//
//  Created by Catherine Schwartz on 17/04/2016.
//  Copyright © 2016 Catherine Schwartz. All rights reserved.
//

import UIKit

class MyCollectionViewFlowLayout: UICollectionViewFlowLayout {

    let cellHeight: CGFloat = 200
    var itemWidth: CGFloat = 200
    let itemRatio: CGFloat = 1.33
    var layoutInfo = [NSIndexPath: UICollectionViewLayoutAttributes]()
    var layoutHeaderInfo = [NSIndexPath: UICollectionViewLayoutAttributes]()
    var collectionViewWidth: CGFloat = 0
    var maxOriginY: CGFloat = 0

    // keep track of max height values to avoid scroll jumps when you have a long collectionView
    var headerHeight = [NSIndexPath: CGFloat]()
    var textHeight: CGFloat = 0.0

    var itemsPerRow = 0

    let numberOfSections = 4

    let sectionImage = 0
    let sectionText = 1
    let sectionItem = 2
    let sectionItem2 = 3


    override init() {
        super.init()
        setup()
    }

    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
        setup()
    }

    func setup() {
        // setting up some inherited values
        
        minimumInteritemSpacing = 0
        minimumLineSpacing = 0
        scrollDirection = UICollectionViewScrollDirection.Horizontal
        
        collectionViewWidth = UIScreen.mainScreen().bounds.width
        if let collectionView = collectionView {
            collectionViewWidth = collectionView.frame.size.width
        }
        
        itemWidth = getItemWidth()
        headerReferenceSize = CGSizeMake(collectionViewWidth, 50)
    }


    func getItemWidth() -> CGFloat {
        // small iphones:   2 items in a row
        // iPhone 6+        3
        // iPad Portrait    4
        // iPad Landsape    5
        
        itemsPerRow = 2
        
        if (UIDevice.currentDevice().userInterfaceIdiom == UIUserInterfaceIdiom.Pad) {
            if (UIDevice.currentDevice().orientation.isLandscape.boolValue) {
                itemsPerRow = 5
            } else {
                itemsPerRow = 4
            }
            
        } else {
            // iPhone
            if (collectionViewWidth > 375.0) { // 375 = width of iPhone 6
                itemsPerRow = 3
            }
        }
        
        return collectionViewWidth / CGFloat(itemsPerRow)
    }
    
    
    // MARK: prepareLayout
    
    override func prepareLayout() {
        
        maxOriginY = 0
        setup()
        
        for i in 0 ..< numberOfSections {
            
            if let collectionView = self.collectionView {
                
                for j in 0 ..< collectionView.numberOfItemsInSection(i) {
                    let indexPath = NSIndexPath(forRow: j, inSection: i)
                    
                    // Headers
                    if ((indexPath.section == sectionItem || indexPath.section == sectionItem2) && indexPath.item == 0) {
                        let headerPath = NSIndexPath(forItem: 0, inSection: indexPath.section)
                        let headerAttributes = UICollectionViewLayoutAttributes(forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withIndexPath: headerPath)
                        headerAttributes.frame = frameForHeaderAtIndexPath(headerPath)
                        maxOriginY += headerAttributes.frame.size.height
                        layoutHeaderInfo[headerPath] = headerAttributes
                    }
                    
                    let itemAttributes = UICollectionViewLayoutAttributes(forCellWithIndexPath: indexPath)
                    itemAttributes.frame = frameForItemAtIndexPath(indexPath)
                    
                    if (indexPath.section < sectionItem) {
                        maxOriginY += itemAttributes.frame.size.height
                        
                    } else if ((indexPath.section == sectionItem || indexPath.section == sectionItem2)) {
                        let allRows = (indexPath.item % Int(itemsPerRow)) == (Int(itemsPerRow) - 1)
                        let lastRow = indexPath.item == (collectionView.numberOfItemsInSection(i) - 1)
                        
                        if (allRows || lastRow) {
                            // add height only if there is "itemsPerRow" items per row, or if multiple rows: last item per row
                            maxOriginY += itemAttributes.frame.size.height
                        }
                    }
                    layoutInfo[indexPath] = itemAttributes
                    
    //                    print("- \(i).\(j): itemAttributes y: \(itemAttributes.frame.origin.y) - itemAttributes height: \(itemAttributes.frame.size.height) - maxOriginY: \(maxOriginY)")
                }
            }
        }
    }


    func frameForItemAtIndexPath(indexPath: NSIndexPath) -> CGRect {
        
        if (indexPath.section == sectionImage) {
            return CGRectMake(0, maxOriginY, collectionViewWidth, collectionViewWidth)
            
        } else if (indexPath.section == sectionText) {
            
            var currentCellHeight = max(textHeight, cellHeight)
            if let collectionView = self.collectionView {
                if let cell = collectionView.cellForItemAtIndexPath(indexPath) as? TextCell {
                    textHeight = max(textHeight, cell.frame.height)
                    currentCellHeight = textHeight
                }
            }
            return CGRectMake(0, maxOriginY, collectionViewWidth, currentCellHeight) // width, height
            
        } else if (indexPath.section == sectionItem || indexPath.section == sectionItem2) {
            
            let currentColumn = ceil(CGFloat(indexPath.item % itemsPerRow))
            let posX = currentColumn * itemWidth
            let rect = CGRectMake(posX, maxOriginY, itemWidth, itemWidth * itemRatio)
            
            return rect
        }
        return CGRectZero
    }
    
    
    func frameForHeaderAtIndexPath(indexPath: NSIndexPath) -> CGRect {
        
        if (indexPath.section == sectionItem || indexPath.section == sectionItem2) {
            var currentCellHeight: CGFloat = 50
            if let collectionView = self.collectionView {
                if let cell = collectionView.supplementaryViewForElementKind(UICollectionElementKindSectionHeader, atIndexPath: indexPath) as? HeaderView {
                    if let height = headerHeight[indexPath] {
                        headerHeight[indexPath] = max(cell.frame.height, height)
                    } else {
                        headerHeight[indexPath] = cell.frame.height
                    }
                    currentCellHeight = cell.frame.height
                }
            }
            
            if let height = headerHeight[indexPath] {
                currentCellHeight = height
            }
            return CGRectMake(0, maxOriginY, collectionViewWidth, currentCellHeight) // width, height
        }
        return CGRectZero
    }
    
    
    // MARK: collectionViewContentSize
    override func collectionViewContentSize() -> CGSize {
        
        guard let collectionView = self.collectionView else { return CGSizeMake(UIScreen.mainScreen().bounds.width, maxOriginY)}
        return CGSizeMake(collectionView.frame.width, maxOriginY)
    }
    
    
    // MARK: layoutAttributesForElementsInRect
    override func layoutAttributesForElementsInRect(rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        
        var allAttributes: [UICollectionViewLayoutAttributes] = [UICollectionViewLayoutAttributes]()

        // Header
        for (_, attributes) in layoutHeaderInfo {
            if CGRectIntersectsRect(rect, attributes.frame) {
                allAttributes.append(attributes)
            }
        }
        
        for (_, attributes) in layoutInfo {
            if CGRectIntersectsRect(rect, attributes.frame) {
                allAttributes.append(attributes)
            }
        }

        return allAttributes
    }

    // MARK: Header and cells layout attributes
    override func layoutAttributesForSupplementaryViewOfKind(elementKind: String, atIndexPath indexPath: NSIndexPath) -> UICollectionViewLayoutAttributes? {
        return layoutHeaderInfo[indexPath]
    }

    override func layoutAttributesForItemAtIndexPath(indexPath: NSIndexPath) -> UICollectionViewLayoutAttributes? {
        return layoutInfo[indexPath]
    }
    
    
    
    override func shouldInvalidateLayoutForBoundsChange(newBounds: CGRect) -> Bool {
        // if you don't want to re-calculate everything on scroll
        return !CGSizeEqualToSize(newBounds.size, self.collectionView!.frame.size)
    }


    override func shouldInvalidateLayoutForPreferredLayoutAttributes(preferredAttributes: UICollectionViewLayoutAttributes, withOriginalAttributes originalAttributes: UICollectionViewLayoutAttributes) -> Bool {
        
        if (originalAttributes.indexPath.section >= sectionText) {
            // true only for sections that needs to be updated (the ones that are changing size)
            // ie. the ones that are using preferredLayoutAttributesFittingAttributes to self-resize
            return true
        }
        return false
    }

}
