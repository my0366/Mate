//
//  LoginCoordinator.swift
//  Mate
//
//  Created by Jae Kyeong Ko on 2022/12/13.
//

import UIKit

import RxSwift
import RxRelay

protocol LoginCoordinatorDelegate {
    func removeLoginCoordinator(_ coordinator: LoginCoordinator)
}

final class LoginCoordinator: Coordinator, LoginViewControllerDelegate {
    private let disposeBag = DisposeBag()
    var childCoordinators: [Coordinator] = []
    var delegate: LoginCoordinatorDelegate?

    private let navigationController: UINavigationController
    private var viewController: LoginViewController?
    private let viewModel: LoginViewModel

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
        self.viewModel = LoginViewModel()
    }

    func start() {
        viewController = LoginViewController()
        viewController?.delegate = self
        navigationController.navigationBar.isHidden = true
        navigationController.pushViewController(viewController ?? UIViewController(),
                                                 animated: true)
    }

    func didLoginButtonTapped() {
        viewModel.requestLogin(
            studentNumber: viewController?.studentNumber,
            memberName: viewController?.memberName,
            phoneNumber: viewController?.phoneNumber).subscribe { [weak self] response in
                if let element = response.element {
                    UserDefaultsRepository.saveIsLoggedIn(value: true)
                    UserDefaultsRepository.saveGrantType(value: element.grantType)
                    UserDefaultsRepository.saveAccessToken(value: element.accessToken)

                    UserDefaultsRepository.saveUserData(studentNumber: self?.viewController?.studentNumber ?? "",
                                                        name: self?.viewController?.memberName ?? "",
                                                        phoneNumber: self?.viewController?.phoneNumber ?? "")
                    self?.pushToHome()
                }
            }.disposed(by: disposeBag)
    }

    func pushToHome() {
        delegate?.removeLoginCoordinator(self)

        let coordinator = HomeCoordinator(navigationController: navigationController)
        coordinator.start()
    }
}
