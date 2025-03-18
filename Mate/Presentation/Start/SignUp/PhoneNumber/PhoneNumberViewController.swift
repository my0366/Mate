//
//  PhoneNumberViewController.swift
//  Mate
//
//  Created by Jae Kyeong Ko on 2022/11/17.
//

import UIKit

import RxCocoa
import RxSwift
import SnapKit

protocol PhoneNumberViewControllerDelegate {
    func pushToUserType()
}

final class PhoneNumberViewController: UIViewController {
    private let disposeBag = DisposeBag()

    var delegate: PhoneNumberViewControllerDelegate?
    var phoneNumber: String?

    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "전화번호를 입력해주세요."
        label.font = UIFont.instance(name: .notoSansKRBold, size: 22)
        label.textColor = UIColor(colorSet: .shadeBlack)
        return label
    }()
    private lazy var numberView: InfoFormView = {
        let infoView = InfoFormView()
        infoView.titleLabelText = "전화번호"
        infoView.textFieldPlaceHolder = "예: 01012345678"
        infoView.textFieldKeyBoardType = .numberPad
        return infoView
    }()
    private lazy var nextButton: RoundedButton = {
        let button = RoundedButton()
        button.title = "다음"
        button.isEnabled = false
        return button
    }()
    private lazy var toolbar: UIToolbar = {
        let toolbar = UIToolbar(
            frame: CGRect(x: 0,
                          y: 0,
                          width: view.bounds.width,
                          height: 40)
        )
        let flexSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace,
                                        target: nil,
                                        action: nil)
        let doneButton = UIBarButtonItem(title: "완료",
                                         style: .done,
                                         target: self,
                                         action: #selector(hideKeyboard))
        toolbar.items = [flexSpace, doneButton]
        return toolbar
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
        bind()
        showKeyboard()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.topItem?.title = ""
        navigationController?.navigationBar.isHidden = true
    }

    private func bind() {
        nextButton.rx.tap
            .bind(onNext: { [weak self] in
                self?.phoneNumber = self?.numberView.textFieldText
                self?.delegate?.pushToUserType()
            })
            .disposed(by: disposeBag)
    }

    private func showKeyboard() {
        numberView.showKeyboard()
    }

    @objc
    private func hideKeyboard() {
        nextButton.isEnabled = numberView.textFieldText?.count == 11
        numberView.hideKeyboard()
    }
}

private extension PhoneNumberViewController {
    func configure() {
        configureViews()
        configureConstraints()
    }

    func configureViews() {
        view.backgroundColor = UIColor(colorSet: .background)

        numberView.textFieldInputAccessoryView = toolbar

        [titleLabel, numberView, nextButton].forEach {
            view.addSubview($0)
        }
    }

    func configureConstraints() {
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(68)
            make.leading.equalToSuperview().offset(16)
        }

        numberView.snp.makeConstraints { make in
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
