//
//  SceneDelegate.swift
//  Mate
//
//  Created by Jae Kyeong Ko on 2022/11/17.
//

import UIKit

final class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var window: UIWindow?

    func scene(_ scene: UIScene,
               willConnectTo session: UISceneSession,
               options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(windowScene: windowScene)

        let navigationController = UINavigationController()
        window?.rootViewController = navigationController

        let coordinator = AppCoordinator(navigationController: navigationController)
        coordinator.start()

        window?.makeKeyAndVisible()
    }
}
