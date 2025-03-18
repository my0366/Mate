//
//  DayChoiceCoordinator.swift
//  Mate
//
//  Created by Jae Kyeong Ko on 2022/11/20.
//

import UIKit

protocol DayChoiceCoordinatorDelegate {
    func removeDayChoiceCoordinator(_ coordinator: DayChoiceCoordinator)
}

final class DayChoiceCoordinator: Coordinator, DayChoiceViewControllerDelegate {
    var childCoordinators: [Coordinator] = []
    var delegate: DayChoiceCoordinatorDelegate?

    private let navigationController: UINavigationController
    private let viewModel: DayChoiceViewModel

    var name: String?
    var studentNumber: String?
    var department: String?
    var phoneNumber: String?
    var auth: String?
    var profileImage: UIImage?

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
        self.viewModel = DayChoiceViewModel()
    }

    func start() {
        let viewController = DayChoiceViewController()
        viewController.viewModel = viewModel
        viewController.delegate = self
        viewModel.name = name
        viewModel.studentNumber = studentNumber
        viewModel.department = department
        viewModel.phoneNumber = phoneNumber
        viewModel.auth = auth
        viewModel.profileImage = profileImage
        navigationController.navigationBar.topItem?.title = ""
        navigationController.pushViewController(viewController, animated: true)
    }

    func popToProfileImage() {
        delegate?.removeDayChoiceCoordinator(self)
    }

    func popToStart() {
        navigationController.popToRootViewController(animated: true)
    }
}
