//
//  TicketPreviewCoordinator.swift
//  Mate
//
//  Created by Jae Kyeong Ko on 2022/12/09.
//

import UIKit

protocol TicketPreviewCoordinatorDelegate {
    func removeTicketPreviewCoordinator(_ coordinator: TicketPreviewCoordinator)
}

final class TicketPreviewCoordinator: Coordinator, TicketPreviewViewControllerDelegate {
    var childCoordinators: [Coordinator] = []
    var delegate: TicketPreviewCoordinatorDelegate?

    private let navigationController: UINavigationController
    private let viewModel: TicketPreviewViewModel

    var startArea: String?
    var boardingPlace: String?
    var date: String?
    var dayStatus: String?
    var time: String?
    var chattingLink: String?
    var numberOfpeople: String?
    var carpoolCost: String?

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
        self.viewModel = TicketPreviewViewModel()
    }

    func start() {
        let viewController = TicketPreviewViewController()
        viewController.viewModel = viewModel
        viewController.delegate = self
        viewController.startArea = startArea
        viewController.boardingPlace = boardingPlace
        viewController.date = date
        viewController.dayStatus = dayStatus
        viewController.time = time
        viewController.numberOfpeople = numberOfpeople
        viewController.carpoolCost = carpoolCost
        viewModel.startArea = startArea
        viewModel.boardingPlace = boardingPlace
        viewModel.date = date
        viewModel.dayStatus = dayStatus
        viewModel.time = time
        viewModel.chattingLink = chattingLink
        viewModel.numberOfpeople = numberOfpeople
        viewModel.carpoolCost = carpoolCost
        navigationController.navigationBar.topItem?.backButtonTitle = ""
        navigationController.pushViewController(viewController, animated: true)
    }

    func popToChattingLink() {
        delegate?.removeTicketPreviewCoordinator(self)
    }

    func popToHome() {
        navigationController.popToRootViewController(animated: true)
    }
}
