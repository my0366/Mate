//
//  DayChoiceViewController.swift
//  Mate
//
//  Created by Jae Kyeong Ko on 2022/11/18.
//

import UIKit

import RxCocoa
import RxSwift
import SnapKit

protocol DayChoiceViewControllerDelegate {
    func popToProfileImage()
    func popToStart()
}

final class DayChoiceViewController: UIViewController {
    private let disposeBag = DisposeBag()
    weak var viewModel: DayChoiceViewModel?
    var delegate: DayChoiceViewControllerDelegate?

    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "이용할 요일을 선택해주세요."
        label.font = UIFont.instance(name: .notoSansKRBold, size: 22)
        label.textColor = UIColor(colorSet: .shadeBlack)
        return label
    }()
    private lazy var stackView: UIStackView = {
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
    private lazy var finishButton: RoundedButton = {
        let button = RoundedButton()
        button.title = "완료하기"
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
        bind()
    }

    private func bind() {
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

        finishButton.rx.tap
            .bind(onNext: { [weak self] in
                self?.buttonStateToDayCode()
                self?.viewModel?.signUp()
            })
            .disposed(by: disposeBag)

        viewModel?.message
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: { [weak self] message in
                self?.showAlert(with: message)
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

    @objc
    private func didBackBarButtonTapped() {
        delegate?.popToProfileImage()
    }

    private func showAlert(with message: String) {
        let alertController = UIAlertController(title: nil,
                                                message: message,
                                                preferredStyle: .alert)
        let action = UIAlertAction(title: "확인", style: .default) { [weak self] _ in
            self?.delegate?.popToStart()
        }

        alertController.addAction(action)
        present(alertController, animated: true)
    }
}

private extension DayChoiceViewController {
    func configure() {
        configureViews()
        configureBarButton()
        configureConstraints()
    }

    func configureViews() {
        view.backgroundColor = UIColor(colorSet: .background)

        [mondayButton, tuesdayButton, wednesdayButton, thursdayButton, fridayButton].forEach {
            stackView.addArrangedSubview($0)
        }

        [titleLabel, stackView, finishButton].forEach {
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
            make.leading.trailing.equalToSuperview().inset(37)
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

        finishButton.snp.makeConstraints { make in
            make.bottom.equalTo(view.safeAreaLayoutGuide).offset(-10)
            make.leading.trailing.equalToSuperview().inset(16)
            make.height.equalTo(50)
        }
    }
}
