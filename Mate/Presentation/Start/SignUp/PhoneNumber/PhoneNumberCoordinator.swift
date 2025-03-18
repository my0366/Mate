//
//  PhoneNumberCoordinator.swift
//  Mate
//
//  Created by Jae Kyeong Ko on 2022/11/20.
//

import UIKit

final class PhoneNumberCoordinator: Coordinator, PhoneNumberViewControllerDelegate {
    var childCoordinators: [Coordinator] = []

    private let navigationController: UINavigationController
    private var viewController: PhoneNumberViewController?

    var name: String?
    var studentNumber: String?
    var department: String?

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func start() {
        viewController = PhoneNumberViewController()
        viewController?.delegate = self
        navigationController.pushViewController(viewController ?? UIViewController(),
                                                animated: true)
    }

    func pushToUserType() {
        let coordinator = UserTypeCoordinator(navigationController: navigationController)
        coordinator.delegate = self
        coordinator.name = name
        coordinator.studentNumber = studentNumber
        coordinator.department = department
        coordinator.phoneNumber = viewController?.phoneNumber
        coordinator.start()
        childCoordinators.append(coordinator)
    }
}

extension PhoneNumberCoordinator: UserTypeCoordinatorDelegate {
    func removeUserTypeCoordinator(_ coordinator: UserTypeCoordinator) {
        childCoordinators = childCoordinators.filter { $0 !== coordinator }
        navigationController.popViewController(animated: true)
    }
}
