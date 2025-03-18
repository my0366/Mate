//
//  SignInCoordinator.swift
//  Mate
//
//  Created by Jae Kyeong Ko on 2022/11/20.
//

import UIKit

protocol SignUpCoordinatorDelegate {
    func removeSignUpCoordinator(_ coordinator: SignUpCoordinator)
}

final class SignUpCoordinator: Coordinator, SignUpViewControllerDelegate {
    var childCoordinators: [Coordinator] = []
    var delegate: SignUpCoordinatorDelegate?

    private let navigationController: UINavigationController
    private var viewController: SignUpViewController?

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func start() {
        viewController = SignUpViewController()
        viewController?.delegate = self
        navigationController.navigationBar.isHidden = true
        navigationController.pushViewController(viewController ?? UIViewController(),
                                                animated: true)
    }

    func pushToPhoneNumber() {
        delegate?.removeSignUpCoordinator(self)

        let coordinator = PhoneNumberCoordinator(navigationController: navigationController)
        coordinator.name = viewController?.name
        coordinator.studentNumber = viewController?.studentNumber
        coordinator.department = viewController?.department
        coordinator.start()
        childCoordinators.append(coordinator)
    }
}
