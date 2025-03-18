//
//  HomeCoordinator.swift
//  Mate
//
//  Created by Jae Kyeong Ko on 2022/11/24.
//

import UIKit
import PanModal

protocol HomeCoordinatorDelegate {
    func removeSelectLocationCoordinator(_ coordinator: SelectLocationCoordinator)
}

final class HomeCoordinator: Coordinator, HomeViewControllerDelegate, ProfileViewCoordinatorDelegate {
    var childCoordinators: [Coordinator] = []

    private let navigationController: UINavigationController
    private let viewModel: HomeViewModel

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
        self.viewModel = HomeViewModel()
    }

    func start() {
        let viewController = HomeViewController()
        viewController.viewModel = viewModel
        viewController.delegate = self
        navigationController.navigationBar.isHidden = true
        navigationController.pushViewController(viewController, animated: true)
    }

    func pushToCreateCarpool() {
        let coordinator = SelectLocationCoordinator(navigationController: navigationController)
        coordinator.delegate = self
        coordinator.start()
        childCoordinators.append(coordinator)
    }

    func pushToProfile() {
        let coordinator = ProfileViewCoordinator(navigationController: navigationController)
        coordinator.delegate = self
        coordinator.start()
        childCoordinators.append(coordinator)
    }
}

extension HomeCoordinator: SelectLocationCoordinatorDelegate {
    func removeSelectLocationCoordinator(_ coordinator: SelectLocationCoordinator) {
        childCoordinators = childCoordinators.filter { $0 !== coordinator }
        navigationController.popViewController(animated: true)
    }
}
