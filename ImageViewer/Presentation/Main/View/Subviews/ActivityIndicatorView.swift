//
//  ActivityIndicatorView.swift
//  ImageViewer
//
//  Created by NIKOLAI BORISOV on 16.02.2022.
//

import UIKit

final class ActivityIndicatorView: UIActivityIndicatorView {
    
    // MARK: - Initializers
    
    init() {
        super.init(frame: .zero)
        self.configureSelf()
    }
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Public Methods
    
    public func setupActivityIndicator(on view: UIView) {
        self.center = view.center
    }
    
    // MARK: - Private Methods
    
    private func configureSelf() {
        self.translatesAutoresizingMaskIntoConstraints = false
        if #available(iOS 13.0, *) {
            self.style = .large
        } else {
            self.style = .whiteLarge
        }
        self.color = .systemRed
        self.hidesWhenStopped = true
    }
    
}
