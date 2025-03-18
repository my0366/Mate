//
//  UserTypeViewController.swift
//  Mate
//
//  Created by Jae Kyeong Ko on 2022/11/18.
//

import UIKit

import RxCocoa
import RxSwift
import SnapKit

protocol UserTypeViewControllerDelegate {
    func pushToProfileImage()
    func popToPhoneNumber()
}

final class UserTypeViewController: UIViewController {
    private let disposeBag = DisposeBag()

    private let segmentedControlHeight: CGFloat = 56

    var delegate: UserTypeViewControllerDelegate?
    var auth: String?

    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "사용자 유형을 선택해주세요."
        label.font = UIFont.instance(name: .notoSansKRBold, size: 22)
        label.textColor = UIColor(colorSet: .shadeBlack)
        return label
    }()
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 8
        return stackView
    }()
    private lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 2
        label.text = "드라이버는 자차보유자를, 패신저는 승객(이용자)를 뜻합니다.\n추후에 변경 가능합니다."
        label.font = UIFont.instance(name: .notoSansKRRegular, size: 13)
        label.textColor = UIColor(colorSet: .neutral50)
        return label
    }()
    private lazy var segmentedControl: RoundedSegmentedControl = {
        let segmentedControl = RoundedSegmentedControl()
        segmentedControl.viewHeight = segmentedControlHeight
        return segmentedControl
    }()
    private lazy var nextButton: RoundedButton = {
        let button = RoundedButton()
        button.title = "다음"
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
        bind()
    }

    private func bind() {
        segmentedControl.driverButton.rx.tap
            .subscribe(onNext: { [weak self] in
                guard let driverButton = self?.segmentedControl.driverButton,
                      let passengerButton = self?.segmentedControl.passengerButton else { return }

                driverButton.isSelected = true
                passengerButton.isSelected = false

                driverButton.configuration?.baseBackgroundColor = UIColor(colorSet: .primary50)
                driverButton.configuration?.baseForegroundColor = UIColor(colorSet: .background)
                passengerButton.configuration?.baseBackgroundColor = UIColor(colorSet: .background)
                passengerButton.configuration?.baseForegroundColor = UIColor(colorSet: .primary50)
            })
            .disposed(by: disposeBag)

        segmentedControl.passengerButton.rx.tap
            .subscribe(onNext: { [weak self] in
                guard let driverButton = self?.segmentedControl.driverButton,
                      let passengerButton = self?.segmentedControl.passengerButton else { return }

                passengerButton.isSelected = true
                driverButton.isSelected = false

                driverButton.configuration?.baseBackgroundColor = UIColor(colorSet: .background)
                driverButton.configuration?.baseForegroundColor = UIColor(colorSet: .primary50)
                passengerButton.configuration?.baseBackgroundColor = UIColor(colorSet: .primary50)
                passengerButton.configuration?.baseForegroundColor = UIColor(colorSet: .background)
            })
            .disposed(by: disposeBag)

        nextButton.rx.tap
            .bind(onNext: { [weak self] in
                let driverButtonIsSelected = self?.segmentedControl.driverButton.isSelected ?? false
                self?.auth = driverButtonIsSelected ? "DRIVER" : "PASSENGER"
                self?.delegate?.pushToProfileImage()
            })
            .disposed(by: disposeBag)
    }

    @objc
    private func didBackBarButtonTapped() {
        delegate?.popToPhoneNumber()
    }
}

private extension UserTypeViewController {
    func configure() {
        configureViews()
        configureBarButton()
        configureConstraints()
    }

    func configureViews() {
        view.backgroundColor = UIColor(colorSet: .background)

        [descriptionLabel, segmentedControl].forEach {
            stackView.addArrangedSubview($0)
        }

        [titleLabel, stackView, nextButton].forEach {
            view.addSubview($0)
        }
    }

    func configureBarButton() {
        let backBarButton = UIBarButtonItem(image: UIImage(imageSet: .arrowLeft),
                                            style: .done, target: self,
                                            action: #selector(didBackBarButtonTapped))

        navigationItem.leftBarButtonItem = backBarButton
    }

    func configureConstraints() {
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(30)
            make.leading.equalToSuperview().offset(16)
        }

        stackView.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(30)
            make.leading.trailing.equalToSuperview().inset(16)
        }

        segmentedControl.snp.makeConstraints { make in
            make.height.equalTo(segmentedControlHeight)
        }

        nextButton.snp.makeConstraints { make in
            make.bottom.equalTo(view.safeAreaLayoutGuide).offset(-10)
            make.leading.trailing.equalToSuperview().inset(16)
            make.height.equalTo(50)
        }
    }
}
