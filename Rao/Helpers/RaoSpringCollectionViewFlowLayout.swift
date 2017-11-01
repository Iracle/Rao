//
//  RaoSpringCollectionViewFlowLayout.swift
//  Rao
//
//  Created by Iracle Zhang on 6/24/16.
//  Copyright © 2016 Iracle. All rights reserved.
//

import UIKit

class RaoSpringCollectionViewFlowLayout: UICollectionViewFlowLayout {
    
    let kCVCellSpacing: CGFloat = 5.0
    let kItemSize: CGFloat = 70.0
    var animator: UIDynamicAnimator?
    
    
    func setUpItemSize() {
        
        self.itemSize = CGSize(width: kItemSize, height: kItemSize)
        self.minimumInteritemSpacing = kCVCellSpacing;
        self.minimumLineSpacing = kCVCellSpacing;
        self.sectionInset = UIEdgeInsetsMake(kCVCellSpacing, kCVCellSpacing, kCVCellSpacing, kCVCellSpacing);
        
    }
    
    // static Layout
    override func prepare() {
        super.prepare()
        
        if animator == nil {

            animator = UIDynamicAnimator(collectionViewLayout: self)
            let contentSize = self.collectionViewContentSize
            guard let items = super.layoutAttributesForElements(in: CGRect(x: 0, y: 0, width: contentSize.width, height: contentSize.height)) else { return }
            
            for item in items {
                let spring = UIAttachmentBehavior(item: item, attachedToAnchor: item.center)
                
                spring.length = 0
                spring.damping = 0.6
                spring.frequency = 1.0
                
                animator?.addBehavior(spring)
            }
        }
    }
    
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        
        return animator?.items(in: rect) as? [UICollectionViewLayoutAttributes] ?? super.layoutAttributesForElements(in: rect)
        
    }
    
    override func layoutAttributesForItem(at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {

        return animator?.layoutAttributesForCell(at: indexPath) ?? super.layoutAttributesForItem(at: indexPath)
        
    }

    override func shouldInvalidateLayout(forBoundsChange newBounds: CGRect) -> Bool {
        
        if let collectionView = self.collectionView, let animator = animator {
            
            let delta = newBounds.origin.y - collectionView.bounds.origin.y
            let touchLocation = collectionView.panGestureRecognizer.location(in: collectionView)
            for behavior in animator.behaviors {
                
                if let spring = behavior as? UIAttachmentBehavior, let item = spring.items.first as? UICollectionViewLayoutAttributes {
                    
                    let yAnchorPoint: CGFloat = spring.anchorPoint.y
                    let distanceFormTouch: CGFloat = fabs(touchLocation.y - yAnchorPoint)
                    let scrollResistance: CGFloat = distanceFormTouch / 5000
                    var center = item.center
                    center.y += delta * scrollResistance
                    item.center = center
                    animator.updateItem(usingCurrentState: item)
                }
            }
        }
        return false
    }
    

}















