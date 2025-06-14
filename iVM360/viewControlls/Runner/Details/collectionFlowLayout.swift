//
//  collectionFlowLayout.swift
//  DexgoHousekeeping
//
//  Created by Apple on 14/05/22.
//

import UIKit
class ColumnFlowLayout: UICollectionViewFlowLayout {
    
    let cellsPerRow: Int
    let cellHeight: Int
    init(cellsPerRow: Int, cellHeight: Int = 0, minimumInteritemSpacing: CGFloat = 0, minimumLineSpacing: CGFloat = 0, sectionInset: UIEdgeInsets = .zero) {
        self.cellsPerRow             = cellsPerRow
        self.cellHeight              = cellHeight
        super.init()
        self.minimumInteritemSpacing = minimumInteritemSpacing
        self.minimumLineSpacing      = minimumLineSpacing
        self.sectionInset            = sectionInset
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepare() {
        super.prepare()
        guard let collectionView = collectionView else { return }
        var marginsAndInsets: CGFloat = 0.0
        if #available(iOS 11.0, *) {
            marginsAndInsets = sectionInset.left + sectionInset.right + collectionView.safeAreaInsets.left + collectionView.safeAreaInsets.right + minimumInteritemSpacing * CGFloat(cellsPerRow - 1)
        } else {
            // Fallback on earlier versions
            marginsAndInsets = sectionInset.left + sectionInset.right + collectionView.layoutMargins.left + collectionView.layoutMargins.right + minimumInteritemSpacing * CGFloat(cellsPerRow - 1)
        }
        let itemWidth  = ((collectionView.bounds.size.width - marginsAndInsets) / CGFloat(cellsPerRow)).rounded(.down)
        let itemHeight = CGFloat(cellHeight) > 0.0 ? CGFloat(cellHeight) : itemWidth
        itemSize       = CGSize(width: itemWidth, height: itemHeight)
    }
    
    override func invalidationContext(forBoundsChange newBounds: CGRect) -> UICollectionViewLayoutInvalidationContext {
        let context = super.invalidationContext(forBoundsChange: newBounds) as! UICollectionViewFlowLayoutInvalidationContext
        context.invalidateFlowLayoutDelegateMetrics = newBounds.size != collectionView?.bounds.size
        return context
    }
    
}


