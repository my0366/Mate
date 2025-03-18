//
//  ChattingLinkViewController.swift
//  Mate
//
//  Created by Jae Kyeong Ko on 2022/12/08.
//

import UIKit

import RxCocoa
import RxSwift
import SnapKit

protocol ChattingLinkViewControllerDelegate {
    func popToSelectDate()
    func pushToTicketPreview()
}

final class ChattingLinkViewController: UIViewController {
    private let disposeBag = DisposeBag()
    var delegate: ChattingLinkViewControllerDelegate?

    var chattingLink: String?
    var numberOfpeople: String?
    var carpoolCost: String?

    private lazy var progressStackView: ProgressStackView = {
        let stackView = ProgressStackView()
        stackView.progressImage1 = UIImage(imageSet: .barFill) ?? UIImage()
        stackView.progressImage2 = UIImage(imageSet: .barFill) ?? UIImage()
        return stackView
    }()
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "오픈 카톡을 입력해주세요."
        label.font = UIFont.instance(name: .notoSansKRBold, size: 22)
        label.textColor = UIColor(colorSet: .shadeBlack)
        return label
    }()
    private lazy var chattingLinkFormView: InfoFormView = {
        let formView = InfoFormView()
        formView.titleLabelText = "오픈 채팅방 링크"
        formView.textFieldPlaceHolder = "링크를 붙여넣기 해주세요."
        return formView
    }()
    private lazy var dropDownStackView = DropDownStackView()
    private lazy var peopleCountMenuView: PeopleCountMenuView = {
        let menuView = PeopleCountMenuView()
        menuView.makeButton(with: PeopleCount.items)
        return menuView
    }()
    private lazy var costMenuView: CostMenuView = {
        let menuView = CostMenuView()
        menuView.makeButton(with: CarpoolCost.items)
        return menuView
    }()
    private lazy var nextButton: RoundedButton = {
        let roundedButton = RoundedButton()
        roundedButton.title = "다음"
        roundedButton.isEnabled = false
        return roundedButton
    }()

    private var isPeopleCountSelected = false
    private var isCostSelected = false

    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
        bind()
    }

    private func bind() {
        dropDownStackView.peopleCountButtonRx.tap
            .bind(onNext: { [weak self] in
                self?.didPeopleDropDownButtonTapped()
            })
            .disposed(by: disposeBag)

        dropDownStackView.costButtonRx.tap
            .bind(onNext: { [weak self] in
                self?.didCostDropDownButtonTapped()
            })
            .disposed(by: disposeBag)

        chattingLinkFormView.textFieldRx.controlEvent(.editingDidEndOnExit)
            .bind(onNext: { [weak self] in
                self?.chattingLinkFormView.hideKeyboard()
            })
            .disposed(by: disposeBag)

        chattingLinkFormView.textFieldRx.controlEvent(.editingDidEnd)
            .bind(onNext: { [weak self] in
                self?.nextButton.isEnabled = !(self?.checkTextFieldsAreEmpty() ?? false)
            })
            .disposed(by: disposeBag)

        nextButton.rx.tap
            .bind(onNext: { [weak self] in
                self?.chattingLink = self?.chattingLinkFormView.textFieldText
                self?.numberOfpeople = self?.dropDownStackView.peopleCountText
                self?.carpoolCost = self?.dropDownStackView.costText
                self?.delegate?.pushToTicketPreview()
            })
            .disposed(by: disposeBag)
    }

    private func didPeopleDropDownButtonTapped() {
        isPeopleCountSelected = !isPeopleCountSelected
        if isPeopleCountSelected {
            peopleCountMenuView.showMenuView(on: view,
                                             below: dropDownStackView.peopleCountDropDownButton)
            isCostSelected = false
            costMenuView.hideMenuView()
        } else {
            peopleCountMenuView.hideMenuView()
        }
    }

    private func didCostDropDownButtonTapped() {
        isCostSelected = !isCostSelected
        if isCostSelected {
            costMenuView.showMenuView(on: view, below: dropDownStackView.costDropDownButton)
            isPeopleCountSelected = false
            peopleCountMenuView.hideMenuView()
        } else {
            costMenuView.hideMenuView()
        }
    }

    private func checkTextFieldsAreEmpty() -> Bool {
        guard let chattingLinkText = chattingLinkFormView.textFieldText,
              let peopleCountText = dropDownStackView.peopleCountText,
              let costText = dropDownStackView.costText else { return true }

        return chattingLinkText.isEmpty || peopleCountText.isEmpty || costText.isEmpty
    }

    @objc
    private func didBackgroundTapped(_ sender: UITapGestureRecognizer) {
        chattingLinkFormView.hideKeyboard()
        peopleCountMenuView.hideMenuView()
        costMenuView.hideMenuView()
        isCostSelected = false
        isPeopleCountSelected = false
    }

    @objc
    private func didBackBarButtonTapped() {
        delegate?.popToSelectDate()
    }
}

private extension ChattingLinkViewController {
    func configure() {
        configureViews()
        configureBarButton()
        configureGestures()
        configureDelegates()
        configureConstraints()
    }

    func configureViews() {
        view.backgroundColor = UIColor(colorSet: .background)

        [progressStackView,
         titleLabel,
         chattingLinkFormView,
         dropDownStackView,
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

    func configureGestures() {
        let gesture = UITapGestureRecognizer(target: self, action: #selector(didBackgroundTapped))
        view.addGestureRecognizer(gesture)
    }

    func configureDelegates() {
        peopleCountMenuView.delegate = self
        costMenuView.delegate = self
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

        chattingLinkFormView.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(28)
            make.leading.trailing.equalToSuperview().inset(16)
        }

        dropDownStackView.snp.makeConstraints { make in
            make.top.equalTo(chattingLinkFormView.snp.bottom).offset(24)
            make.leading.trailing.equalToSuperview().inset(16)
        }

        nextButton.snp.makeConstraints { make in
            make.bottom.equalTo(view.safeAreaLayoutGuide).offset(-10)
            make.leading.trailing.equalToSuperview().inset(16)
            make.height.equalTo(50)
        }
    }
}

extension ChattingLinkViewController: PeopleCountMenuViewDelegate {
    func didPeopleCountMenuButtonTapped(_ sender: UIButton) {
        switch sender.tag {
        case 0:
            dropDownStackView.peopleCountText = PeopleCount.one.rawValue
        case 1:
            dropDownStackView.peopleCountText = PeopleCount.two.rawValue
        case 2:
            dropDownStackView.peopleCountText = PeopleCount.three.rawValue
        case 3:
            dropDownStackView.peopleCountText = PeopleCount.four.rawValue
        default:
            break
        }

        nextButton.isEnabled = !checkTextFieldsAreEmpty()
        isPeopleCountSelected = false
        peopleCountMenuView.hideMenuView()
    }
}

extension ChattingLinkViewController: CostMenuViewDelegate {
    func didCostMenuButtonTapped(_ sender: UIButton) {
        switch sender.tag {
        case 0:
            dropDownStackView.costText = CarpoolCost.free.rawValue
        case 1:
            dropDownStackView.costText = CarpoolCost.pay.rawValue
        default:
            break
        }

        nextButton.isEnabled = !checkTextFieldsAreEmpty()
        isCostSelected = false
        costMenuView.hideMenuView()
    }
}
