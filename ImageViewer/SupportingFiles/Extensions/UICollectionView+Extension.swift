//
//  UICollectionView+Extension.swift
//  ImageViewer
//
//  Created by NIKOLAI BORISOV on 16.02.2022.
//

import UIKit

// MARK: - Register and dequeueCell for UICollectionViewCell

extension UICollectionView {
    
    func register<T: UICollectionViewCell>(cell: T.Type) {
        register(T.self, forCellWithReuseIdentifier: T.identifier)
    }
    
    func dequeueCell<T: UICollectionViewCell>(for indexPath: IndexPath) -> T {
        dequeueReusableCell(withReuseIdentifier: T.identifier, for: indexPath) as! T
    }
    
}

// MARK: - SetupTwoItemsPerRow

extension UICollectionView {
    
    func setupTwoItemsPerRow(on view: UICollectionView, with inset: UIEdgeInsets) -> CGSize {
        let cellSpacing: CGFloat = inset.left
        let itemsPerRow: CGFloat = 2
        let spacing = (itemsPerRow * cellSpacing) + ((itemsPerRow - 1.0) * cellSpacing)
        let size = (view.bounds.width - spacing) / itemsPerRow
        return CGSize(width: size, height: size)
    }
    
}
