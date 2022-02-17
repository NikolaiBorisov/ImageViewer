//
//  LoadableErrorAlertController+Extension.swift
//  ImageViewer
//
//  Created by NIKOLAI BORISOV on 16.02.2022.
//

import UIKit

fileprivate enum AlertConstants {
    static let alertTitle = "Oops :("
    static let reloadButton = "Reload"
    static let cancelButton = "Cancel"
    static let titleKey = "attributedTitle"
    static let messageKey = "attributedMessage"
}

protocol LoadableErrorAlertController {
    func showErrorAlert(with message: AppError, completionReload: @escaping () -> Void?)
}

// MARK: - Present LoadableErrorAlertController

extension LoadableErrorAlertController where Self: UIViewController {
    
    func showErrorAlert(with message: AppError, completionReload: @escaping () -> Void?) {
        DispatchQueue.main.async {
            let alert = UIAlertController(
                title: AlertConstants.alertTitle,
                message: message.title,
                preferredStyle: .alert
            )
            let resetData = UIAlertAction(
                title: AlertConstants.reloadButton,
                style: .default,
                handler: { _ in
                    completionReload()
                }
            )
            let cancel = UIAlertAction(
                title: AlertConstants.cancelButton,
                style: .destructive,
                handler: nil
            )
            alert.addAction(resetData)
            alert.addAction(cancel)
            alert.view.tintColor = .cyan
            alert.view.subviews.first?.subviews.first?.subviews.first?.backgroundColor = UIColor.darkGray
            
            alert.setValue(NSAttributedString(
                string: AlertConstants.alertTitle,
                attributes: [
                    NSAttributedString.Key.font: UIFont.systemFont(ofSize: 16),
                    NSAttributedString.Key.foregroundColor : UIColor.cyan
                ]), forKey: AlertConstants.titleKey)
            alert.setValue(NSAttributedString(
                string: message.title,
                attributes: [
                    NSAttributedString.Key.font: UIFont.systemFont(ofSize:16),
                    NSAttributedString.Key.foregroundColor : UIColor.white
                ]), forKey: AlertConstants.messageKey)
            self.present(alert, animated: true, completion: nil)
        }
    }
    
}
