//
//  ProfileViewCoordinator.swift
//  Mate
//
//  Created by 성제 on 2022/12/07.
//

import Foundation
import UIKit

protocol ProfileViewCoordinatorDelegate {
    func removeSelectLocationCoordinator(_ coordinator: SelectLocationCoordinator)
}

final class ProfileViewCoordinator: Coordinator, ProfileViewControllerDelegate {
    func start() {
        let viewController = ProfileViewController()
        viewController.delegate = self
        navigationController.navigationBar.isHidden = false
        navigationController.pushViewController(viewController, animated: true)
    }

    var childCoordinators: [Coordinator] = []
    var delegate: ProfileViewCoordinatorDelegate?

    private let navigationController: UINavigationController
    private var viewController: SignUpViewController?

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func pushToEditProfile() {

    }
}

extension ProfileViewCoordinator: SelectLocationCoordinatorDelegate {
    func removeSelectLocationCoordinator(_ coordinator: SelectLocationCoordinator) {
        childCoordinators = childCoordinators.filter { $0 !== coordinator }
        navigationController.popViewController(animated: true)
    }
}
