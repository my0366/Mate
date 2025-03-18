//
//  ProfileImageCoordinator.swift
//  Mate
//
//  Created by Jae Kyeong Ko on 2022/11/20.
//

import UIKit

protocol ProfileImageCoordinatorDelegate {
    func removeProfileImageCoordinator(_ coordinator: ProfileImageCoordinator)
}

final class ProfileImageCoordinator: Coordinator, ProfileImageViewControllerDelegate {
    var childCoordinators: [Coordinator] = []
    var delegate: ProfileImageCoordinatorDelegate?

    private let navigationController: UINavigationController
    private var viewController: ProfileImageViewController?

    var name: String?
    var studentNumber: String?
    var department: String?
    var phoneNumber: String?
    var auth: String?

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func start() {
        viewController = ProfileImageViewController()
        viewController?.delegate = self
        navigationController.navigationBar.topItem?.title = ""
        navigationController.pushViewController(viewController ?? UIViewController()
                                                , animated: true)
    }

    func pushToDayChoice() {
        let coordinator = DayChoiceCoordinator(navigationController: navigationController)
        coordinator.delegate = self
        coordinator.name = name
        coordinator.studentNumber = studentNumber
        coordinator.department = department
        coordinator.phoneNumber = phoneNumber
        coordinator.auth = auth
        coordinator.profileImage = viewController?.profileImage
        coordinator.start()
        childCoordinators.append(coordinator)
    }

    func popToUserType() {
        delegate?.removeProfileImageCoordinator(self)
    }
}

extension ProfileImageCoordinator: DayChoiceCoordinatorDelegate {
    func removeDayChoiceCoordinator(_ coordinator: DayChoiceCoordinator) {
        childCoordinators = childCoordinators.filter { $0 !== coordinator }
        navigationController.popViewController(animated: true)
    }
}
