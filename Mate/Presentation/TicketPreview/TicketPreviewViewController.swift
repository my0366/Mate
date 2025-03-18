//
//  TicketPreviewViewController.swift
//  Mate
//
//  Created by Jae Kyeong Ko on 2022/12/09.
//

import UIKit

import RxCocoa
import RxSwift
import SnapKit

protocol TicketPreviewViewControllerDelegate {
    func popToChattingLink()
    func popToHome()
}

final class TicketPreviewViewController: UIViewController {
    private let disposeBag = DisposeBag()
    var viewModel: TicketPreviewViewModel?
    var delegate: TicketPreviewViewControllerDelegate?

    var startArea: String?
    var boardingPlace: String?
    var date: String?
    var dayStatus: String?
    var time: String?
    var numberOfpeople: String?
    var carpoolCost: String?

    private lazy var progressStackView: ProgressStackView = {
        let stackView = ProgressStackView()
        stackView.progressImage1 = UIImage(imageSet: .barFill) ?? UIImage()
        stackView.progressImage2 = UIImage(imageSet: .barFill) ?? UIImage()
        stackView.progressImage3 = UIImage(imageSet: .barFill) ?? UIImage()
        return stackView
    }()
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "티켓 미리보기"
        label.font = UIFont.instance(name: .notoSansKRBold, size: 22)
        label.textColor = UIColor(colorSet: .shadeBlack)
        return label
    }()
    private lazy var ticketDetailView = TicketDetailView()
    private lazy var buttonStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.distribution = .fillEqually
        stackView.spacing = 8
        return stackView
    }()
    private lazy var cancelButton: RoundedButton = {
        let roundedButton = RoundedButton()
        roundedButton.title = "취소하기"
        roundedButton.baseBackgroundColor = UIColor(colorSet: .background)
        roundedButton.baseForegroundColor = UIColor(colorSet: .primary50)
        roundedButton.borderWidth = 1.5
        return roundedButton
    }()
    private lazy var createTicketButton: RoundedButton = {
        let roundedButton = RoundedButton()
        roundedButton.title = "티켓 생성하기"
        return roundedButton
    }()

    private var combinedDateTime: String {
        guard let date = date,
              let dayStatus = dayStatus,
              let time = time else { return "" }

        let monthDay = date.components(separatedBy: "/")
        let minuteSecond = time.components(separatedBy: ":")

        return "\(dayStatus) \(minuteSecond[0])시\(minuteSecond[1])분,\(monthDay[0])월\(monthDay[1])일"
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
        updateUI()
        bind()
    }

    private func updateUI() {
        ticketDetailView.startAreaText = startArea
        ticketDetailView.timeText = combinedDateTime
        ticketDetailView.boardingPlaceText = boardingPlace
        ticketDetailView.numberOfPeopleText = numberOfpeople
        ticketDetailView.costText = carpoolCost
    }

    private func bind() {
        cancelButton.rx.tap
            .bind(onNext: { [weak self] in
                self?.delegate?.popToHome()
            })
            .disposed(by: disposeBag)

        createTicketButton.rx.tap
            .bind(onNext: { [weak self] in
                self?.viewModel?.createCarpool()
            })
            .disposed(by: disposeBag)

        viewModel?.message
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: { [weak self] message in
                self?.showAlert(with: message)
            })
            .disposed(by: disposeBag)
    }

    @objc
    private func didBackBarButtonTapped() {
        delegate?.popToChattingLink()
    }

    private func showAlert(with message: String) {
        let alertController = UIAlertController(title: nil,
                                                message: message,
                                                preferredStyle: .alert)
        let action = UIAlertAction(title: "확인", style: .default) { [weak self] _ in
            self?.delegate?.popToHome()
        }

        alertController.addAction(action)
        present(alertController, animated: true)
    }
}

private extension TicketPreviewViewController {
    func configure() {
        configureViews()
        configureBarButton()
        configureConstraints()
    }

    func configureViews() {
        view.backgroundColor = UIColor(colorSet: .background)

        [cancelButton, createTicketButton].forEach {
            buttonStackView.addArrangedSubview($0)
        }

        [progressStackView, titleLabel, ticketDetailView, buttonStackView].forEach {
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
        progressStackView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(12)
            make.leading.trailing.equalToSuperview().inset(16)
        }

        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(progressStackView.snp.bottom).offset(20)
            make.leading.trailing.equalToSuperview().inset(16)
        }

        ticketDetailView.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(30)
            make.leading.trailing.equalToSuperview().inset(16)
        }

        cancelButton.snp.makeConstraints { make in
            make.height.equalTo(50)
        }

        createTicketButton.snp.makeConstraints { make in
            make.height.equalTo(50)
        }

        buttonStackView.snp.makeConstraints { make in
            make.bottom.equalTo(view.safeAreaLayoutGuide).offset(-10)
            make.leading.trailing.equalToSuperview().inset(16)
        }
    }
}
