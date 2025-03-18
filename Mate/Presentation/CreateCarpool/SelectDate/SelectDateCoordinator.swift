//
//  SelectDateCoordinator.swift
//  Mate
//
//  Created by Jae Kyeong Ko on 2022/12/02.
//

import UIKit

protocol SelectDateCoordinatorDelegate {
    func removeSelectDateCoordinator(_ coordinator: SelectDateCoordinator)
}

final class SelectDateCoordinator: Coordinator, SelectDateViewConrollerDelegate {
    var childCoordinators: [Coordinator] = []
    var delegate: SelectDateCoordinatorDelegate?

    private let navigationController: UINavigationController
    private var viewController: SelectDateViewController?

    var startArea: String?
    var boardingPlace: String?

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func start() {
        viewController = SelectDateViewController()
        viewController?.delegate = self
        navigationController.navigationBar.topItem?.backButtonTitle = ""
        navigationController.pushViewController(viewController ?? UIViewController(),
                                                animated: true)
    }

    func pushToChattingLink() {
        let coordinator = ChattingLinkCoordinator(navigationController: navigationController)
        coordinator.delegate = self
        coordinator.startArea = startArea
        coordinator.boardingPlace = boardingPlace
        coordinator.date = viewController?.date
        coordinator.dayStatus = viewController?.dayStatus
        coordinator.time = viewController?.time
        coordinator.start()
        childCoordinators.append(coordinator)
    }

    func popToSelectLocation() {
        delegate?.removeSelectDateCoordinator(self)
    }
}

extension SelectDateCoordinator: ChattingLinkCoordinatorDelegate {
    func removeChattingLinkCoordinator(_ coordinator: ChattingLinkCoordinator) {
        childCoordinators = childCoordinators.filter { $0 !== coordinator }
        navigationController.popViewController(animated: true)
    }
}
