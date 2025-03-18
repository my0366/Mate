//
//  ChattingLinkCoordinator.swift
//  Mate
//
//  Created by Jae Kyeong Ko on 2022/12/08.
//

import UIKit

protocol ChattingLinkCoordinatorDelegate {
    func removeChattingLinkCoordinator(_ coordinator: ChattingLinkCoordinator)
}

final class ChattingLinkCoordinator: Coordinator, ChattingLinkViewControllerDelegate {
    var childCoordinators: [Coordinator] = []
    var delegate: ChattingLinkCoordinatorDelegate?

    var startArea: String?
    var boardingPlace: String?
    var date: String?
    var dayStatus: String?
    var time: String?

    private let navigationController: UINavigationController
    private var viewController: ChattingLinkViewController?

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func start() {
        viewController = ChattingLinkViewController()
        viewController?.delegate = self
        navigationController.navigationBar.topItem?.backButtonTitle = ""
        navigationController.pushViewController(viewController ?? UIViewController(),
                                                animated: true)
    }

    func pushToTicketPreview() {
        let coordinator = TicketPreviewCoordinator(navigationController: navigationController)
        coordinator.delegate = self
        coordinator.startArea = startArea
        coordinator.boardingPlace = boardingPlace
        coordinator.date = date
        coordinator.dayStatus = dayStatus
        coordinator.time = time
        coordinator.chattingLink = viewController?.chattingLink
        coordinator.numberOfpeople = viewController?.numberOfpeople
        coordinator.carpoolCost = viewController?.carpoolCost
        coordinator.start()
        childCoordinators.append(coordinator)
    }

    func popToSelectDate() {
        delegate?.removeChattingLinkCoordinator(self)
    }
}

extension ChattingLinkCoordinator: TicketPreviewCoordinatorDelegate {
    func removeTicketPreviewCoordinator(_ coordinator: TicketPreviewCoordinator) {
        childCoordinators = childCoordinators.filter { $0 !== coordinator }
        navigationController.popViewController(animated: true)
    }
}
