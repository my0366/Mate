//
//  LoginViewController.swift
//  Mate
//
//  Created by Jae Kyeong Ko on 2022/11/18.
//

import UIKit

import RxCocoa
import RxSwift
import SnapKit

protocol LoginViewControllerDelegate {
    func didLoginButtonTapped()
    func pushToHome()
}

final class LoginViewController: UIViewController {
    private let disposeBag = DisposeBag()
    var viewModel: DayChoiceViewModel?
    var delegate: LoginViewControllerDelegate?

    var studentNumber: String?
    var memberName: String?
    var phoneNumber: String?

    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "로그인하기"
        label.font = UIFont.instance(name: .notoSansKRBold, size: 22)
        label.textColor = UIColor(colorSet: .shadeBlack)
        return label
    }()
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 24
        return stackView
    }()
    private lazy var nameFormView: InfoFormView = {
        let infoFormView = InfoFormView()
        infoFormView.titleLabelText = "이름"
        infoFormView.textFieldPlaceHolder = "예: 메이트"
        return infoFormView
    }()
    private lazy var studentNumberFormView: InfoFormView = {
        let infoFormView = InfoFormView()
        infoFormView.titleLabelText = "학번"
        infoFormView.textFieldPlaceHolder = "예: 123a123"
        return infoFormView
    }()
    private lazy var phoneNumberFormView: InfoFormView = {
        let infoFormView = InfoFormView()
        infoFormView.titleLabelText = "전화번호"
        infoFormView.textFieldPlaceHolder = "예: 01012345678"
        return infoFormView
    }()
    private lazy var loginButton: RoundedButton = {
        let button = RoundedButton()
        button.title = "로그인 하기"
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
        bind()
    }

    private func bind() {
        loginButton.rx.tap
            .bind(onNext: { [weak self] in
                self?.studentNumber = self?.studentNumberFormView.textFieldText
                self?.memberName = self?.nameFormView.textFieldText
                self?.phoneNumber = self?.phoneNumberFormView.textFieldText
                self?.delegate?.didLoginButtonTapped()
            })
            .disposed(by: disposeBag)
    }
}

private extension LoginViewController {
    func configure() {
        configureViews()
        configureConstraints()
    }

    func configureViews() {
        view.backgroundColor = UIColor(colorSet: .background)
        navigationController?.navigationBar.isHidden = true

        [nameFormView, studentNumberFormView, phoneNumberFormView].forEach {
            stackView.addArrangedSubview($0)
        }

        [titleLabel, stackView, loginButton].forEach {
            view.addSubview($0)
        }
    }

    func configureConstraints() {
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(68)
            make.leading.equalToSuperview().offset(16)
        }

        stackView.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(30)
            make.leading.trailing.equalToSuperview().inset(16)
        }

        loginButton.snp.makeConstraints { make in
            make.bottom.equalTo(view.safeAreaLayoutGuide).offset(-10)
            make.leading.trailing.equalToSuperview().inset(16)
            make.height.equalTo(50)
        }
    }
}
