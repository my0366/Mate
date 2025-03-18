//
//  SelectDateViewController.swift
//  Mate
//
//  Created by Jae Kyeong Ko on 2022/12/02.
//

import UIKit

import RxCocoa
import RxSwift
import SnapKit

protocol SelectDateViewConrollerDelegate {
    func popToSelectLocation()
    func pushToChattingLink()
}

final class SelectDateViewController: UIViewController {
    private let disposeBag = DisposeBag()
    var delegate: SelectDateViewConrollerDelegate?

    var date: String?
    var dayStatus: String?
    var time: String?

    private lazy var progressStackView: ProgressStackView = {
        let stackView = ProgressStackView()
        stackView.progressImage1 = UIImage(imageSet: .barFill) ?? UIImage()
        return stackView
    }()
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "출발시간을 설정해주세요."
        label.font = UIFont.instance(name: .notoSansKRBold, size: 22)
        label.textColor = UIColor(colorSet: .shadeBlack)
        return label
    }()
    private lazy var dateFormView: InfoFormView = {
        let formView = InfoFormView()
        formView.titleLabelText = "출발 날짜"
        formView.textFieldPlaceHolder = "MM/DD, 예: 11/30"
        formView.textFieldText = Date().tomorrowDateString
        return formView
    }()
    private lazy var selectTimeView = SelectTimeView()
    private lazy var menuView: MenuView = {
        let menuView = MenuView()
        menuView.makeButton(with: DayStatus.items)
        return menuView
    }()
    private lazy var nextButton: RoundedButton = {
        let roundedButton = RoundedButton()
        roundedButton.title = "다음"
        roundedButton.isEnabled = false
        return roundedButton
    }()

    private var dropDownButtonIsSelected = false

    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
        bind()
    }

    private func bind() {
        selectTimeView.dropDownButtonRx.tap
            .bind(onNext: { [weak self] in
                self?.didDropDownButtonTapped()
            })
            .disposed(by: disposeBag)

        dateFormView.textFieldRx.controlEvent(.editingDidEndOnExit)
            .bind(onNext: { [weak self] in
                self?.dateFormView.hideKeyboard()
            })
            .disposed(by: disposeBag)

        selectTimeView.timeTextFieldRx.controlEvent(.editingDidEndOnExit)
            .bind(onNext: { [weak self] in
                self?.selectTimeView.hideKeyboard()
            })
            .disposed(by: disposeBag)

        dateFormView.textFieldRx.controlEvent(.editingDidEnd)
            .bind(onNext: { [weak self] in
                self?.nextButton.isEnabled = !(self?.checkTextFieldsAreEmpty() ?? false)
            })
            .disposed(by: disposeBag)

        selectTimeView.timeTextFieldRx.controlEvent(.editingDidEnd)
            .bind(onNext: { [weak self] in
                self?.nextButton.isEnabled = !(self?.checkTextFieldsAreEmpty() ?? false)
            })
            .disposed(by: disposeBag)

        nextButton.rx.tap
            .bind(onNext: { [weak self] in
                self?.date = self?.dateFormView.textFieldText
                self?.dayStatus = self?.selectTimeView.dropDownButtonText
                self?.time = self?.selectTimeView.timeTextFieldText
                self?.delegate?.pushToChattingLink()
            })
            .disposed(by: disposeBag)
    }

    private func checkTextFieldsAreEmpty() -> Bool {
        guard let dateTextField = dateFormView.textFieldText,
              let timeTextField = selectTimeView.timeTextFieldText else { return false }

        return dateTextField.isEmpty || timeTextField.isEmpty
    }

    private func didDropDownButtonTapped() {
        dropDownButtonIsSelected = !dropDownButtonIsSelected
        if dropDownButtonIsSelected {
            menuView.showMenuView(on: view, below: selectTimeView.dropDownButton)
        } else {
            menuView.hideMenuView()
        }
    }

    @objc
    private func didBackBarButtonTapped() {
        delegate?.popToSelectLocation()
    }

    @objc
    private func didBackgroundTapped(_ sender: UITapGestureRecognizer) {
        selectTimeView.hideKeyboard()
        menuView.hideMenuView()
        dropDownButtonIsSelected = false
    }
}

private extension SelectDateViewController {
    func configure() {
        configureViews()
        configureBarButton()
        configureDelegates()
        configureGestures()
        configureConstraints()
    }

    func configureViews() {
        view.backgroundColor = UIColor(colorSet: .background)

        [progressStackView, titleLabel, dateFormView, selectTimeView, nextButton].forEach {
            view.addSubview($0)
        }
    }

    func configureBarButton() {
        let backBarButton = UIBarButtonItem(image: UIImage(imageSet: .arrowLeft),
                                            style: .done, target: self,
                                            action: #selector(didBackBarButtonTapped))

        navigationItem.leftBarButtonItem = backBarButton
    }

    func configureDelegates() {
        menuView.delegate = self
    }

    func configureGestures() {
        let gesture = UITapGestureRecognizer(target: self, action: #selector(didBackgroundTapped))
        view.addGestureRecognizer(gesture)
    }

    func configureConstraints() {
        progressStackView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(12)
            make.leading.trailing.equalToSuperview().inset(16)
        }

        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(progressStackView.snp.bottom).offset(20)
            make.leading.trailing.equalToSuperview().inset(16)
        }

        dateFormView.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(28)
            make.leading.trailing.equalToSuperview().inset(16)
        }

        selectTimeView.snp.makeConstraints { make in
            make.top.equalTo(dateFormView.snp.bottom).offset(24)
            make.leading.trailing.equalToSuperview().inset(16)
        }

        nextButton.snp.makeConstraints { make in
            make.bottom.equalTo(view.safeAreaLayoutGuide).offset(-10)
            make.leading.trailing.equalToSuperview().inset(16)
            make.height.equalTo(50)
        }
    }
}

extension SelectDateViewController: MenuViewDelegate {
    func didMenuButtonTapped(_ sender: UIButton) {
        switch sender.tag {
        case 0:
            selectTimeView.dropDownButtonText = DayStatus.morning.rawValue
        case 1:
            selectTimeView.dropDownButtonText = DayStatus.afternoon.rawValue
        default:
            break
        }

        dropDownButtonIsSelected = false
        menuView.hideMenuView()
    }
}
