//
//  AppCoordinator.swift
//  Mate
//
//  Created by Jae Kyeong Ko on 2022/11/20.
//

import UIKit
import RxSwift

protocol Coordinator: AnyObject {
    var childCoordinators: [Coordinator] { get set }

    func start()
}

class AppCoordinator: Coordinator {
    var childCoordinators: [Coordinator] = []

    private let navigationController: UINavigationController
    private let isLoggedIn = UserDefaultsRepository.isLoggedIn

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func start() {
//        if isLoggedIn {
//            showHomeViewController()
//        } else {
//            showStartViewController()
//        }
        AuthRepository.requestLogin(
            loginRequestDTO: LoginRequestDTO(studentNumber: UserDefaultsRepository.studentNumber,
                                             memberName: UserDefaultsRepository.name,
                                             phoneNumber: UserDefaultsRepository.phoneNumber)
        ) { responseToken in
            UserDefaultsRepository.saveAccessToken(value: responseToken.accessToken)
            self.showHomeViewController()
        } failure: { error in
            self.showStartViewController()
        }
    }

    private func showStartViewController() {
        let coordinator = StartCoordinator(navigationController: navigationController)
        coordinator.start()
        childCoordinators.append(coordinator)
    }

    private func showHomeViewController() {
        let coordinator = HomeCoordinator(navigationController: navigationController)
        coordinator.start()
        childCoordinators.append(coordinator)
    }
}
