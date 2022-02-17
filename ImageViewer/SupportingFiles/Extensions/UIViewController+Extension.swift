//
//  UIViewController+Extension.swift
//  ImageViewer
//
//  Created by NIKOLAI BORISOV on 16.02.2022.
//

import UIKit

// MARK: - Custom NavBar

extension UIViewController {
    
    func setupNavBar(withTitle title: String? = nil) {
        guard let navBar = navigationController?.navigationBar else { return }
        self.title = title
        navBar.prefersLargeTitles = true
        navBar.tintColor = .black
        navBar.backgroundColor = .white
        navBar.largeTitleTextAttributes = [.foregroundColor: UIColor.black]
        navigationItem.backButtonTitle = ""
    }
    
}
