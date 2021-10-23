//
//  SceneDelegate.swift
//  Exemplary App
//
//  Created by Герман Иванилов on 29.08.2021.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    private var rootModule: RootModule?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {

        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        setupUI(windowScene: windowScene)
    }

    private func setupUI(windowScene: UIWindowScene) {
        
        window = UIWindow(windowScene: windowScene)
        let rootModule = RootModule(window: window ?? UIWindow())
        rootModule.input.configureNavigationStack()
        self.window?.makeKeyAndVisible()
        self.rootModule = rootModule
    }

}

