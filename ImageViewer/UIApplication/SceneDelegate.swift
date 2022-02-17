//
//  SceneDelegate.swift
//  ImageViewer
//
//  Created by NIKOLAI BORISOV on 16.02.2022.
//

import UIKit

@available(iOS 13.0, *)
class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    // MARK: - Public Properties
    
    public var window: UIWindow?
    
    // MARK: - Public Methods
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(windowScene: windowScene)
        window?.rootViewController = createInitialVC()
        window?.makeKeyAndVisible()
    }
    
    // MARK: - Private Methods
    
    private func createInitialVC() -> UINavigationController {
        UINavigationController(rootViewController: MainViewController())
    }
}
