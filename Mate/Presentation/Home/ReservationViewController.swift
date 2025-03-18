//
//  ReservationViewController.swift
//  Mate
//
//  Created by 성제 on 2022/12/11.
//

import PanModal
import RxSwift
import UIKit
import SwiftUI

class ReservationViewController: UIViewController {

    private let disposeBag = DisposeBag()
    private var isPassenger = false
    private var passenger: Int = 1
    private let joinChatView = JoinChatView()
    private var reservationDetailView = ReservationDetailView()

    private lazy var exitButton: UIButton = {
        let button = UIButton()
        var config = UIButton.Configuration.plain()
        config.image = UIImage(named: ImageSet.exitButton.rawValue)
        config.cornerStyle = .capsule
        button.configuration = config
        return button
    }()
    private lazy var startPointStackView: BoxStackView = {
        let stackView = BoxStackView()
        stackView.point = "출발지"
        stackView.destination = "안동"
        stackView.layer.cornerRadius = 4
        stackView.layer.borderColor = UIColor(colorSet: .neutral30)?.cgColor
        stackView.isLayoutMarginsRelativeArrangement = true
        stackView.layoutMargins = UIEdgeInsets(top: 8, left: 12, bottom: 8, right: 8)
        stackView.layer.borderWidth = 1
        return stackView
    }()
    private lazy var dottedArrowImageView = UIImageView(image: UIImage(imageSet: .dottedArrow))
    private lazy var carImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(imageSet: .car))
        imageView.backgroundColor = UIColor(colorSet: .background)
        return imageView
    }()
    private lazy var endPointStackView: BoxStackView = {
        let stackView = BoxStackView()
        stackView.point = "도착지"
        stackView.destination = "경운대학교"
        stackView.layer.cornerRadius = 4
        stackView.layer.borderColor = UIColor(colorSet: .neutral30)?.cgColor
        stackView.isLayoutMarginsRelativeArrangement = true
        stackView.layoutMargins = UIEdgeInsets(top: 8, left: 12, bottom: 8, right: 8)
        stackView.layer.borderWidth = 1
        return stackView
    }()
    private lazy var driverLabel: UILabel = {
        let label = UILabel()
        label.text = "드라이버"
        label.font = UIFont.instance(name: .notoSansKRBold, size: 12)
        label.textColor = UIColor(colorSet: .neutral50)
        return label
    }()
    private lazy var passengerLabel: UILabel = {
        let label = UILabel()
        label.text = "패신저 (\(passenger)/3)"
        label.font = UIFont.instance(name: .notoSansKRBold, size: 14)
        label.textColor = UIColor(colorSet: .neutral50)
        return label
    }()
    private lazy var endTicketButton: RoundedButton = {
        let button = RoundedButton()
        button.title = "운행 종료"
        button.baseForegroundColor = .white
        button.baseBackgroundColor = UIColor(colorSet: .primary50)
        return button
    }()
    private lazy var deleteTicketButton: RoundedButton = {
        let button = RoundedButton()
        button.title = "티켓 삭제"
        button.baseForegroundColor = UIColor(colorSet: .primary50)
        button.baseBackgroundColor = .white
        button.layer.borderColor = UIColor(colorSet: .primary50)?.cgColor
        button.layer.borderWidth = 1.5
        button.layer.cornerRadius = 25
        return button
    }()
    private lazy var cancelTicketButton: RoundedButton = {
        let button = RoundedButton()
        button.title = "예약 취소"
        button.baseForegroundColor = UIColor(colorSet: .primary50)
        button.baseBackgroundColor = .white
        button.layer.borderColor = UIColor(colorSet: .primary50)?.cgColor
        button.layer.borderWidth = 1.5
        button.layer.cornerRadius = 25
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
        if isPassenger {
            configureAuthIsPassenger()
        } else {
            configureAuthIsDriver()
        }
        bind()
    }
}

extension ReservationViewController {

    func bind() {
        bindData()
        bindButton()
    }

    func bindData() {
        TicketViewModel.shared.myTicketDataSubject.value.forEach { ticketData in
            if ticketData.ticketType == "COST" {
                self.reservationDetailView.price = "유료"
            } else {
                self.reservationDetailView.price = "무료"
            }

            if ticketData.dayStatus == "MORNING" {
                self.reservationDetailView.boardingTime = """
                    오전 \(ticketData.startTime.stringToMonth())시,
                    \(ticketData.startDayMonth.stringToMonth())월 \(ticketData.startDayMonth.stringToMonth())일
                """
            } else {
                self.reservationDetailView.boardingTime = """
                    오후 \(ticketData.startTime.stringToMonth())시,
                    \(ticketData.startDayMonth.stringToMonth())월 \(ticketData.startDayMonth.stringToMonth())일
                """
            }

            self.reservationDetailView.numberOfPassengers = ticketData.recruitPerson
            self.reservationDetailView.attendDestination = ticketData.startArea
    //        self.driverNameLabel.text = ticketData.memberName
            self.startPointStackView.destination = ticketData.startArea
            self.endPointStackView.destination = ticketData.endArea
        }
        
    }

    func bindButton() {
        exitButton.rx.tap
            .bind(onNext: { [weak self] in
                self?.dismiss(animated: true)
            })
            .disposed(by: disposeBag)

        endTicketButton.rx.tap
            .bind(onNext: { [weak self] in
                self?.showEndAlert(with: TicketViewModel.endMessage)
            })
            .disposed(by: disposeBag)

        deleteTicketButton.rx.tap
            .bind(onNext: { [weak self] in
                self?.showDeleteAlert(with: TicketViewModel.deleteMessage)
            })
            .disposed(by: disposeBag)

        cancelTicketButton.rx.tap
            .bind(onNext: { [weak self] in
                self?.showCancelAlert(with: TicketViewModel.cancelMessage)
            })
            .disposed(by: disposeBag)
    }

    func showDeleteAlert(with message: String) {
        let alertController = UIAlertController(title: "티켓을 삭제하시겠어요?",
                                                message: message,
                                                preferredStyle: .alert)
        let acceptAction = UIAlertAction(title: "확인", style: .default)
        let cancelAction = UIAlertAction(title: "취소", style: .cancel)

        alertController.addAction(acceptAction)
        alertController.addAction(cancelAction)
        present(alertController, animated: true)
    }

    func showEndAlert(with message: String) {
        let alertController = UIAlertController(title: "운행을 종료합니다.",
                                                message: message,
                                                preferredStyle: .alert)
        let acceptAction = UIAlertAction(title: "확인", style: .default)
        let cancelAction = UIAlertAction(title: "취소", style: .cancel) { _ in
            TicketViewModel.shared.updateTicket(id: 1, status: "CANCEL")
        }

        alertController.addAction(acceptAction)
        alertController.addAction(cancelAction)
        present(alertController, animated: true)
    }

    func showCancelAlert(with message: String) {
        let alertController = UIAlertController(title: "예약을 취소하시겠어요?",
                                                message: message,
                                                preferredStyle: .alert)
        let acceptAction = UIAlertAction(title: "확인", style: .default)
        let cancelAction = UIAlertAction(title: "취소", style: .cancel)

        alertController.addAction(acceptAction)
        alertController.addAction(cancelAction)
        present(alertController, animated: true)
    }
}
extension ReservationViewController {

    func configure() {
        configureViews()
        configureConstraints()
    }

    func configureViews() {
        view.backgroundColor = UIColor(colorSet: .background)

        [exitButton,
         carImageView,
         dottedArrowImageView,
         startPointStackView,
         endPointStackView,
         reservationDetailView,
         joinChatView,
         driverLabel].forEach {
            view.addSubview($0)
        }
    }

    func configureConstraints() {
        exitButton.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(21)
            make.trailing.equalToSuperview().inset(25)
            make.width.height.equalTo(24)
        }

        startPointStackView.snp.makeConstraints { make in
            make.top.equalTo(exitButton.snp.bottom).offset(25)
            make.leading.equalToSuperview().inset(20)
            make.width.equalTo(120)
            make.height.equalTo(56)
        }

        dottedArrowImageView.snp.makeConstraints { make in
            make.centerY.equalTo(startPointStackView)
            make.leading.equalTo(startPointStackView.snp.trailing).offset(15)
            make.trailing.equalTo(endPointStackView.snp.leading).offset(-15)
        }

        carImageView.snp.makeConstraints { make in
            make.center.equalTo(dottedArrowImageView)
        }

        endPointStackView.snp.makeConstraints { make in
            make.top.equalTo(exitButton.snp.bottom).offset(25)
            make.trailing.equalToSuperview().inset(20)
            make.width.equalTo(120)
            make.height.equalTo(56)
        }

        reservationDetailView.snp.makeConstraints { make in
            make.top.equalTo(startPointStackView.snp.bottom).offset(20)
            make.leading.trailing.equalToSuperview().inset(20)
            make.height.equalTo(88)
        }

        joinChatView.snp.makeConstraints { make in
            make.top.equalTo(reservationDetailView.snp.bottom).offset(20)
            make.leading.trailing.equalToSuperview().inset(20)
            make.height.equalTo(36)
        }

        driverLabel.snp.makeConstraints { make in
            make.top.equalTo(joinChatView.snp.bottom).offset(20)
            make.leading.equalToSuperview().inset(20)
        }
    }

    func configureAuthIsPassenger() {

        [cancelTicketButton].forEach {
            view.addSubview($0)
        }

        cancelTicketButton.snp.makeConstraints { make in
            make.bottom.equalTo(view.safeAreaLayoutGuide).offset(-16)
            make.leading.trailing.equalToSuperview().inset(12.5)
            make.height.equalTo(50)
        }
    }

    func configureAuthIsDriver() {

        [deleteTicketButton,
         endTicketButton].forEach {
            view.addSubview($0)
        }

        deleteTicketButton.snp.makeConstraints { make in
            make.bottom.equalTo(view.safeAreaLayoutGuide).offset(-16)
            make.leading.equalToSuperview().inset(12.5)
            make.trailing.equalTo(endTicketButton.snp.leading).inset(-8)
            make.height.equalTo(50)
        }

        endTicketButton.snp.makeConstraints { make in
            make.bottom.equalTo(view.safeAreaLayoutGuide).offset(-16)
            make.trailing.equalToSuperview().inset(12.5)
            make.width.equalTo(178)
            make.height.equalTo(50)
        }
    }
}

extension ReservationViewController: PanModalPresentable {

    var showDragIndicator: Bool {
        return false
    }
    var panScrollable: UIScrollView? {
        return nil
    }

    var longFormHeight: PanModalHeight {
        return .maxHeightWithTopInset(0)
    }

    var anchorModalToLongForm: Bool {
        return true
    }
}

struct ReservationViewController_Previews: PreviewProvider {
    static var previews: some View {
        ReservationViewController()
            .getRepresentable()
            .edgesIgnoringSafeArea(.all)
    }
}
