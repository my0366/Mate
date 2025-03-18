//
//  SignInViewController.swift
//  Mate
//
//  Created by Jae Kyeong Ko on 2022/11/17.
//

import UIKit

import RxCocoa
import RxSwift
import SnapKit

protocol SignUpViewControllerDelegate {
    func pushToPhoneNumber()
}

final class SignUpViewController: UIViewController {
    private let disposeBag = DisposeBag()

    var delegate: SignUpViewControllerDelegate?
    var name: String?
    var studentNumber: String?
    var department: String?

    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "이름을 입력해주세요."
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
    private lazy var departmentFormView: InfoFormView = {
        let infoFormView = InfoFormView()
        infoFormView.titleLabelText = "학과"
        infoFormView.textFieldPlaceHolder = "예: 미학과"
        return infoFormView
    }()
    private lazy var nextButton: RoundedButton = {
        let button = RoundedButton()
        button.title = "다음"
        button.isEnabled = false
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
        bind()
        nameFormView.showKeyboard()
    }

    private func bind() {
        nameFormView.textFieldRx.controlEvent(.editingDidEndOnExit)
            .subscribe(onNext: { [weak self] in
                guard let self = self else { return }
                if self.stackView.subviews.count == 1 {
                    self.stackView.insertArrangedSubview(self.studentNumberFormView, at: 0)
                    self.studentNumberFormView.showKeyboard()
                    self.titleLabel.text = "학번을 입력해주세요."
                }
                self.checkTextFieldNotEmpty()
            })
            .disposed(by: disposeBag)

        studentNumberFormView.textFieldRx.controlEvent(.editingDidEndOnExit)
            .subscribe(onNext: { [weak self] in
                guard let self = self else { return }
                if self.stackView.subviews.count == 2 {
                    self.stackView.insertArrangedSubview(self.departmentFormView, at: 0)
                    self.departmentFormView.showKeyboard()
                    self.titleLabel.text = "학과를 입력해주세요."
                }
                self.checkTextFieldNotEmpty()
            })
            .disposed(by: disposeBag)

        departmentFormView.textFieldRx.controlEvent(.editingDidEndOnExit)
            .subscribe(onNext: { [weak self] in
                guard let self = self else { return }
                self.departmentFormView.hideKeyboard()
                self.checkTextFieldNotEmpty()
            })
            .disposed(by: disposeBag)

        nextButton.rx.tap
            .subscribe(onNext: { [weak self] in
                self?.name = self?.nameFormView.textFieldText
                self?.studentNumber = self?.studentNumberFormView.textFieldText
                self?.department = self?.departmentFormView.textFieldText
                self?.delegate?.pushToPhoneNumber()
            })
            .disposed(by: disposeBag)
    }

    private func checkTextFieldNotEmpty() {
        guard let nameText = nameFormView.textFieldText,
              let studentIdText = studentNumberFormView.textFieldText,
              let departmentText = departmentFormView.textFieldText else { return }
        let isEmpty = !nameText.isEmpty && !studentIdText.isEmpty && !departmentText.isEmpty
        nextButton.isEnabled = isEmpty
    }
}

private extension SignUpViewController {
    func configure() {
        configureViews()
        configureConstraints()
    }

    func configureViews() {
        view.backgroundColor = UIColor(colorSet: .background)

        stackView.addArrangedSubview(nameFormView)

        [titleLabel, stackView, nextButton].forEach {
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

        nextButton.snp.makeConstraints { make in
            make.bottom.equalTo(view.safeAreaLayoutGuide).offset(-10)
            make.leading.trailing.equalToSuperview().inset(16)
            make.height.equalTo(50)
        }
    }
}
