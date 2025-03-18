//
//  SelectLocationCoordinator.swift
//  Mate
//
//  Created by Jae Kyeong Ko on 2022/11/30.
//

import UIKit

protocol SelectLocationCoordinatorDelegate {
    func removeSelectLocationCoordinator(_ coordinator: SelectLocationCoordinator)
}

final class SelectLocationCoordinator: Coordinator, SelectLocationViewControllerDelegate {
    var childCoordinators: [Coordinator] = []
    var delegate: SelectLocationCoordinatorDelegate?

    private let navigationController: UINavigationController
    private var viewController: SelectLocationViewController?

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func start() {
        viewController = SelectLocationViewController()
        viewController?.delegate = self
        navigationController.navigationBar.isHidden = false
        navigationController.navigationBar.topItem?.backButtonTitle = ""
        navigationController.navigationBar.tintColor = UIColor(colorSet: .dark)
        navigationController.pushViewController(viewController ?? UIViewController(),
                                                animated: true)
    }

    func pushToSelectDate() {
        let coordinator = SelectDateCoordinator(navigationController: navigationController)
        coordinator.delegate = self
        coordinator.startArea = viewController?.startArea
        coordinator.boardingPlace = viewController?.boardingPlace
        coordinator.start()
        childCoordinators.append(coordinator)
    }

    func popToHome() {
        delegate?.removeSelectLocationCoordinator(self)
    }
}

extension SelectLocationCoordinator: SelectDateCoordinatorDelegate {
    func removeSelectDateCoordinator(_ coordinator: SelectDateCoordinator) {
        childCoordinators = childCoordinators.filter { $0 !== coordinator }
        navigationController.popViewController(animated: true)
    }
}
