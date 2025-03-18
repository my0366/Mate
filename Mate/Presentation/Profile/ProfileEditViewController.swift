//
//  ProfileEditViewController.swift
//  Mate
//
//  Created by 성제 on 2022/12/07.
//

import UIKit
import SnapKit
import RxSwift
import SwiftUI

class ProfileEditViewController: UIViewController {

    let disposeBag = DisposeBag()

    var viewModel: ProfileViewModel?

    private let segmentedControlHeight: CGFloat = 56

    private lazy var phoneNumberTextField: InfoFormView = {
        let infoView = InfoFormView()
        infoView.titleLabelText = "전화번호"
        infoView.textFieldPlaceHolder = "예: 01012345678"
        infoView.textFieldKeyBoardType = .numberPad
        return infoView
    }()
    private lazy var typeSelectStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 8
        return stackView
    }()
    private lazy var userTypeLabel: UILabel = {
        let label = UILabel()
        label.text = "사용자 유형"
        label.font = UIFont.instance(name: .notoSansKRRegular, size: 13)
        label.textColor = UIColor(colorSet: .neutral50)
        return label
    }()
    private lazy var segmentedControl: RoundedSegmentedControl = {
        let segmentedControl = RoundedSegmentedControl()
        segmentedControl.viewHeight = segmentedControlHeight
        return segmentedControl
    }()
    private lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 2
        label.text = "드라이버는 자차보유자를, 패신저는 승객(이용자)를 뜻합니다.\n추후에 변경 가능합니다."
        label.font = UIFont.instance(name: .notoSansKRRegular, size: 13)
        label.textColor = UIColor(colorSet: .neutral50)
        return label
    }()
    private lazy var nextButton: RoundedButton = {
        let button = RoundedButton()
        button.title = "수정완료"
        return button
    }()
    private lazy var selectDayLabel: UILabel = {
        let label = UILabel()
        label.text = "이용할 요일을 선택해주세요."
        label.font = UIFont.instance(name: .notoSansKRBold, size: 22)
        label.textColor = UIColor(colorSet: .shadeBlack)
        return label
    }()
    private lazy var dayStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .equalSpacing
        stackView.alignment = .center
        return stackView
    }()
    private lazy var mondayButton: DayButton = {
        let button = DayButton()
        button.title = "월"
        return button
    }()
    private lazy var tuesdayButton: DayButton = {
        let button = DayButton()
        button.title = "화"
        return button
    }()
    private lazy var wednesdayButton: DayButton = {
        let button = DayButton()
        button.title = "수"
        return button
    }()
    private lazy var thursdayButton: DayButton = {
        let button = DayButton()
        button.title = "목"
        return button
    }()
    private lazy var fridayButton: DayButton = {
        let button = DayButton()
        button.title = "금"
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
        bind()
    }

    @objc
    func didBackBarButtonTapped() {
        navigationController?.popViewController(animated: true)
    }

    func bind() {
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

        mondayButton.rx.tap
            .bind(onNext: { [weak self] in
                guard let button = self?.mondayButton else { return }

                button.isSelected = !button.isSelected

                if button.isSelected {
                    button.configuration?.baseForegroundColor = .white
                    button.configuration?.baseBackgroundColor = UIColor(colorSet: .primary60)
                } else {
                    button.configuration?.baseForegroundColor = UIColor(colorSet: .shadeGray)
                    button.configuration?.baseBackgroundColor = UIColor(colorSet: .background)
                }
            })
            .disposed(by: disposeBag)

        tuesdayButton.rx.tap
            .bind(onNext: { [weak self] in
                guard let button = self?.tuesdayButton else { return }

                button.isSelected = !button.isSelected

                if button.isSelected {
                    button.configuration?.baseForegroundColor = .white
                    button.configuration?.baseBackgroundColor = UIColor(colorSet: .primary60)
                } else {
                    button.configuration?.baseForegroundColor = UIColor(colorSet: .shadeGray)
                    button.configuration?.baseBackgroundColor = UIColor(colorSet: .background)
                }
            })
            .disposed(by: disposeBag)

        wednesdayButton.rx.tap
            .bind(onNext: { [weak self] in
                guard let button = self?.wednesdayButton else { return }

                button.isSelected = !button.isSelected

                if button.isSelected {
                    button.configuration?.baseForegroundColor = .white
                    button.configuration?.baseBackgroundColor = UIColor(colorSet: .primary60)
                } else {
                    button.configuration?.baseForegroundColor = UIColor(colorSet: .shadeGray)
                    button.configuration?.baseBackgroundColor = UIColor(colorSet: .background)
                }
            })
            .disposed(by: disposeBag)

        thursdayButton.rx.tap
            .bind(onNext: { [weak self] in
                guard let button = self?.thursdayButton else { return }

                button.isSelected = !button.isSelected

                if button.isSelected {
                    button.configuration?.baseForegroundColor = .white
                    button.configuration?.baseBackgroundColor = UIColor(colorSet: .primary60)
                } else {
                    button.configuration?.baseForegroundColor = UIColor(colorSet: .shadeGray)
                    button.configuration?.baseBackgroundColor = UIColor(colorSet: .background)
                }
            })
            .disposed(by: disposeBag)

        fridayButton.rx.tap
            .bind(onNext: { [weak self] in
                guard let button = self?.fridayButton else { return }

                button.isSelected = !button.isSelected

                if button.isSelected {
                    button.configuration?.baseForegroundColor = .white
                    button.configuration?.baseBackgroundColor = UIColor(colorSet: .primary60)
                } else {
                    button.configuration?.baseForegroundColor = UIColor(colorSet: .shadeGray)
                    button.configuration?.baseBackgroundColor = UIColor(colorSet: .background)
                }
            })
            .disposed(by: disposeBag)
    }

    private func buttonStateToDayCode() {
        if mondayButton.isSelected {
            viewModel?.memberTimeTable.append(TimeTable(dayCode: "0"))
        }
        if tuesdayButton.isSelected {
            viewModel?.memberTimeTable.append(TimeTable(dayCode: "1"))
        }
        if wednesdayButton.isSelected {
            viewModel?.memberTimeTable.append(TimeTable(dayCode: "2"))
        }
        if thursdayButton.isSelected {
            viewModel?.memberTimeTable.append(TimeTable(dayCode: "3"))
        }
        if fridayButton.isSelected {
            viewModel?.memberTimeTable.append(TimeTable(dayCode: "4"))
        }
    }
}

extension ProfileEditViewController {

    func configure() {
        configureViews()
        configureConstraints()
        configureNavigationBar()
    }

    func configureViews() {
        view.backgroundColor = .white

        [phoneNumberTextField, typeSelectStackView, nextButton, dayStackView, selectDayLabel].forEach {
            view.addSubview($0)
        }

        [mondayButton, tuesdayButton, wednesdayButton, thursdayButton, fridayButton].forEach {
            dayStackView.addArrangedSubview($0)
        }

        [userTypeLabel, segmentedControl, descriptionLabel].forEach {
            typeSelectStackView.addArrangedSubview($0)
        }
    }

    func configureConstraints() {
        phoneNumberTextField.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(16)
            make.leading.trailing.equalToSuperview().inset(16.5)
        }

        typeSelectStackView.snp.makeConstraints { make in
            make.top.equalTo(phoneNumberTextField.snp.bottom).offset(40)
            make.leading.trailing.equalToSuperview().inset(16)
        }

        segmentedControl.snp.makeConstraints { make in
            make.height.equalTo(segmentedControlHeight)
        }

        selectDayLabel.snp.makeConstraints { make in
            make.top.equalTo(typeSelectStackView.snp.bottom).offset(40)
            make.leading.trailing.equalToSuperview().inset(16.5)
        }

        dayStackView.snp.makeConstraints { make in
            make.top.equalTo(selectDayLabel.snp.bottom).offset(30)
            make.leading.trailing.equalToSuperview().inset(38)
        }

        mondayButton.snp.makeConstraints { make in
            make.width.height.equalTo(44)
        }

        tuesdayButton.snp.makeConstraints { make in
            make.width.height.equalTo(44)
        }

        wednesdayButton.snp.makeConstraints { make in
            make.width.height.equalTo(44)
        }

        thursdayButton.snp.makeConstraints { make in
            make.width.height.equalTo(44)
        }

        fridayButton.snp.makeConstraints { make in
            make.width.height.equalTo(44)
        }

        nextButton.snp.makeConstraints { make in
            make.bottom.equalTo(view.safeAreaLayoutGuide).offset(-10)
            make.leading.trailing.equalToSuperview().inset(16)
            make.height.equalTo(50)
        }
    }

    func configureNavigationBar() {
        let backBarButton = UIBarButtonItem(image: UIImage(imageSet: .arrowLeft),
                                            style: .plain,
                                            target: self,
                                            action: #selector(didBackBarButtonTapped))

        navigationItem.leftBarButtonItem = backBarButton
        navigationItem.leftBarButtonItem?.tintColor = .black
        navigationController?.navigationBar.backgroundColor = .white
        self.title = "내 정보 수정"
    }
}

struct ProfileEditViewController_Previews: PreviewProvider {
    static var previews: some View {
        ProfileEditViewController()
            .getRepresentable()
            .edgesIgnoringSafeArea(.all)
    }
}
