//
//  StartCoordinator.swift
//  Mate
//
//  Created by Jae Kyeong Ko on 2022/11/20.
//

import UIKit

final class StartCoordinator: Coordinator, StartViewControllerDelegate {
    var childCoordinators: [Coordinator] = []

    private let navigationController: UINavigationController

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func start() {
        let viewController = StartViewController()
        viewController.delegate = self
        navigationController.pushViewController(viewController, animated: true)
    }

    func pushToSignUp() {
        let coordinator = SignUpCoordinator(navigationController: navigationController)
        coordinator.delegate = self
        coordinator.start()
        childCoordinators.append(coordinator)
    }

    func pushToLogin() {
        let coordinator = LoginCoordinator(navigationController: navigationController)
        coordinator.delegate = self
        coordinator.start()
        childCoordinators.append(coordinator)
    }
}

extension StartCoordinator: SignUpCoordinatorDelegate {
    func removeSignUpCoordinator(_ coordinator: SignUpCoordinator) {
        childCoordinators = childCoordinators.filter { $0 !== coordinator }
    }
}

extension StartCoordinator: LoginCoordinatorDelegate {
    func removeLoginCoordinator(_ coordinator: LoginCoordinator) {
        childCoordinators = childCoordinators.filter { $0 !== coordinator }
    }
}
