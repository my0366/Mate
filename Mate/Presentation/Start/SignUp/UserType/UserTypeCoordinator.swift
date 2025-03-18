//
//  UserTypeCoordinator.swift
//  Mate
//
//  Created by Jae Kyeong Ko on 2022/11/20.
//

import UIKit

protocol UserTypeCoordinatorDelegate {
    func removeUserTypeCoordinator(_ coordinator: UserTypeCoordinator)
}

final class UserTypeCoordinator: Coordinator, UserTypeViewControllerDelegate {
    var childCoordinators: [Coordinator] = []
    var delegate: UserTypeCoordinatorDelegate?

    private let navigationController: UINavigationController
    private var viewController: UserTypeViewController?

    var name: String?
    var studentNumber: String?
    var department: String?
    var phoneNumber: String?

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func start() {
        viewController = UserTypeViewController()
        viewController?.delegate = self
        navigationController.navigationBar.isHidden = false
        navigationController.navigationBar.topItem?.backButtonTitle = ""
        navigationController.navigationBar.tintColor = UIColor(colorSet: .dark)
        navigationController.pushViewController(viewController ?? UIViewController(),
                                                animated: true)
    }

    func pushToProfileImage() {
        let coordinator = ProfileImageCoordinator(navigationController: navigationController)
        coordinator.delegate = self
        coordinator.name = name
        coordinator.studentNumber = studentNumber
        coordinator.department = department
        coordinator.phoneNumber = phoneNumber
        coordinator.auth = viewController?.auth
        coordinator.start()
        childCoordinators.append(coordinator)
    }

    func popToPhoneNumber() {
        delegate?.removeUserTypeCoordinator(self)
    }
}

extension UserTypeCoordinator: ProfileImageCoordinatorDelegate {
    func removeProfileImageCoordinator(_ coordinator: ProfileImageCoordinator) {
        childCoordinators = childCoordinators.filter { $0 !== coordinator }
        navigationController.popViewController(animated: true)
    }
}
