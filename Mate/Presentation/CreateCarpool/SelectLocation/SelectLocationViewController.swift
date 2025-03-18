//
//  CreateCarpoolViewController.swift
//  Mate
//
//  Created by Jae Kyeong Ko on 2022/11/25.
//

import UIKit

import RxCocoa
import RxSwift
import SnapKit

protocol SelectLocationViewControllerDelegate {
    func pushToSelectDate()
    func popToHome()
}

final class SelectLocationViewController: UIViewController {
    private let disposeBag = DisposeBag()

    var delegate: SelectLocationViewControllerDelegate?
    var startArea: String?
    var boardingPlace: String?

    private lazy var progressStackView = ProgressStackView()
    private lazy var titleStackView = TitleStackView()
    private lazy var startAreaView = StartAreaView()
    private lazy var menuView: MenuView = {
        let menuView = MenuView()
        menuView.makeButton(with: Areas.items)
        return menuView
    }()
    private lazy var boardingPlaceFormView: InfoFormView = {
        let infoFormView = InfoFormView()
        infoFormView.titleLabelText = "탑승 장소"
        infoFormView.textFieldPlaceHolder = "예: 인동사우나 앞"
        return infoFormView
    }()
    private lazy var nextButton: RoundedButton = {
        let button = RoundedButton()
        button.title = "다음"
        button.isEnabled = false
        return button
    }()

    var isStartAreaDropDownButtonSelected = false

    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
        bind()
    }

    private func bind() {
        boardingPlaceFormView.textFieldRx.controlEvent(.editingDidEndOnExit)
            .bind(onNext: { [weak self] in
                self?.boardingPlaceFormView.hideKeyboard()
            })
            .disposed(by: disposeBag)

        boardingPlaceFormView.textFieldRx.controlEvent(.editingDidEnd)
            .bind { [weak self] in
                self?.nextButton.isEnabled = !(self?.checkTextFieldsAreEmpty() ?? false)
            }
            .disposed(by: disposeBag)

        nextButton.rx.tap
            .bind(onNext: { [weak self] in
                self?.startArea = self?.startAreaView.startArea
                self?.boardingPlace = self?.boardingPlaceFormView.textFieldText
                self?.delegate?.pushToSelectDate()
            })
            .disposed(by: disposeBag)
    }

    private func checkTextFieldsAreEmpty() -> Bool {
        guard let text = boardingPlaceFormView.textFieldText else { return false }

        return startAreaView.checkTextFieldIsEmpty() || text.isEmpty
    }

    @objc
    private func didBackgroundTapped(_ sender: UITapGestureRecognizer) {
        boardingPlaceFormView.hideKeyboard()
        menuView.hideMenuView()
        isStartAreaDropDownButtonSelected = false
    }

    @objc
    private func didBackBarButtonTapped() {
        delegate?.popToHome()
    }
}

private extension SelectLocationViewController {
    func configure() {
        configureViews()
        configureBarButton()
        configureDelegates()
        configureGestures()
        configureConstraints()
    }

    func configureViews() {
        view.backgroundColor = UIColor(colorSet: .background)

        [progressStackView,
         titleStackView,
         startAreaView,
         boardingPlaceFormView,
         nextButton].forEach {
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
        startAreaView.delegate = self
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

        titleStackView.snp.makeConstraints { make in
            make.top.equalTo(progressStackView.snp.bottom).offset(20)
            make.leading.trailing.equalToSuperview().inset(16)
        }

        startAreaView.snp.makeConstraints { make in
            make.top.equalTo(titleStackView.snp.bottom).offset(30)
            make.leading.trailing.equalToSuperview().inset(16)
        }

        boardingPlaceFormView.snp.makeConstraints { make in
            make.top.equalTo(startAreaView.snp.bottom).offset(24)
            make.leading.trailing.equalToSuperview().inset(16)
        }

        nextButton.snp.makeConstraints { make in
            make.bottom.equalTo(view.safeAreaLayoutGuide).offset(-10)
            make.leading.trailing.equalToSuperview().inset(16)
            make.height.equalTo(50)
        }
    }
}

extension SelectLocationViewController: MenuViewDelegate {
    func didMenuButtonTapped(_ sender: UIButton) {
        switch sender.tag {
        case 0:
            startAreaView.startArea = Areas.inDong.rawValue
        case 1:
            startAreaView.startArea = Areas.okGye.rawValue
        case 2:
            startAreaView.startArea = Areas.daeGu.rawValue
        case 3:
            startAreaView.startArea = Areas.etc.rawValue
        default:
            break
        }

        nextButton.isEnabled = !checkTextFieldsAreEmpty()
        isStartAreaDropDownButtonSelected = false
        menuView.hideMenuView()
    }
}

extension SelectLocationViewController: StartAreaDropDownButtonDelegate {
    func didStartAreaDropDownButtonTapped() {
        isStartAreaDropDownButtonSelected = !isStartAreaDropDownButtonSelected
        if isStartAreaDropDownButtonSelected {
            menuView.showMenuView(on: view, below: startAreaView)
        } else {
            menuView.hideMenuView()
        }
    }
}
