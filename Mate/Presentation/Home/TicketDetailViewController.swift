//
//  TicketDetailView.swift
//  Mate
//
//  Created by 성제 on 2022/12/15.
//

import PanModal
import RxCocoa
import RxSwift
import UIKit
import SwiftUI

class TicketDetailViewController: UIViewController {

    let disposeBag = DisposeBag()
    var id: Int = 0
    private var isPassenger = false
    private var reservationDetailView = ReservationDetailView()

    let imageViewHeight: CGFloat = 44

    private lazy var exitButton: UIButton = {
        let button = UIButton()
        var config = UIButton.Configuration.plain()
        config.image = UIImage(named: ImageSet.exitButton.rawValue)
        button.configuration = config
        return button
    }()
    private lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.cornerRadius = imageViewHeight / 2
        imageView.layer.masksToBounds = true
        imageView.backgroundColor = .gray
        return imageView
    }()
    private lazy var driverLabel: UILabel = {
        let label = UILabel()
        label.text = "드라이버"
        label.font = UIFont.instance(name: .notoSansKRBold, size: 12)
        label.textColor = UIColor(colorSet: .neutral50)
        return label
    }()
    private lazy var driverNameLabel: UILabel = {
        let label = UILabel()
        label.text = "이름"
        label.font = UIFont.instance(name: .notoSansKRRegular, size: 14)
        label.textColor = UIColor(colorSet: .shadeBlack)
        return label
    }()
    private lazy var arrowRightImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.masksToBounds = true
        imageView.image = UIImage(named: ImageSet.arrowRight.rawValue)
        return imageView
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
    private lazy var startTicketButton: RoundedButton = {
        let button = RoundedButton()
        button.title = "탑승하기"
        button.baseForegroundColor = .white
        button.baseBackgroundColor = UIColor(colorSet: .primary50)
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
        bind()
    }

    func bind() {
        TicketViewModel.shared.ticketDetailSubject.subscribe { data in
            if let detail = data.element {
                if detail.ticketType == "COST" {
                    self.reservationDetailView.price = "유료"
                } else {
                    self.reservationDetailView.price = "무료"
                }

                if detail.dayStatus == "MORNING" {
                    self.reservationDetailView.boardingTime = "오전 \(detail.startTime.stringToMonth())시, \(detail.startDayMonth.stringToMonth())월 \(detail.startDayMonth.stringToDay())일"
                } else {
                    self.reservationDetailView.boardingTime = "오후 \(detail.startTime.stringToMonth())시, \(detail.startDayMonth.stringToMonth())월 \(detail.startDayMonth.stringToDay())일"
                }

                self.reservationDetailView.numberOfPassengers = detail.recruitPerson
                self.reservationDetailView.attendDestination = detail.startArea
                self.driverNameLabel.text = detail.memberName
                self.startPointStackView.destination = detail.startArea
                self.endPointStackView.destination = detail.endArea
            }
        }.disposed(by: disposeBag)

        startTicketButton.rx.tap
            .bind(onNext: {
            })
            .disposed(by: disposeBag)

        exitButton.rx.tap
            .bind(onNext: { [weak self] in
                self?.dismiss(animated: true)
            })
            .disposed(by: disposeBag)
    }
}

extension TicketDetailViewController {

    func configure() {
        TicketViewModel.shared.getTicketDetailData(id: id)
        configureViews()
        configureConstraints()
    }

    func configureViews() {
        view.backgroundColor = UIColor(colorSet: .background)

        [exitButton,
         imageView,
         driverLabel,
         driverNameLabel,
         startPointStackView,
         carImageView,
         dottedArrowImageView,
         endPointStackView,
         reservationDetailView,
         startTicketButton].forEach {
            view.addSubview($0)
        }
    }

    func configureConstraints() {

        exitButton.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(21)
            make.trailing.equalToSuperview().inset(25)
            make.width.height.equalTo(24)
        }

        imageView.snp.makeConstraints { make in
            make.top.equalTo(startPointStackView.snp.bottom).offset(17)
            make.leading.equalToSuperview().inset(20)
            make.width.height.equalTo(44)
        }

        driverLabel.snp.makeConstraints { make in
            make.top.equalTo(startPointStackView.snp.bottom).offset(20)
            make.leading.equalTo(imageView.snp.trailing).offset(9)
        }

        driverNameLabel.snp.makeConstraints { make in
            make.top.equalTo(driverLabel.snp.bottom)
            make.leading.equalTo(imageView.snp.trailing).offset(9)
        }

        startPointStackView.snp.makeConstraints { make in
            make.top.equalTo(exitButton.snp.bottom).offset(20)
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
            make.top.equalTo(exitButton.snp.bottom).offset(20)
            make.trailing.equalToSuperview().inset(20)
            make.width.equalTo(120)
            make.height.equalTo(56)
        }

        reservationDetailView.snp.makeConstraints { make in
            make.top.equalTo(imageView.snp.bottom).offset(20)
            make.leading.trailing.equalToSuperview().inset(20)
            make.height.equalTo(88)
        }

        startTicketButton.snp.makeConstraints { make in
            make.bottom.equalTo(view.safeAreaLayoutGuide).offset(16)
            make.leading.trailing.equalToSuperview().inset(16)
            make.height.equalTo(50)
        }
    }
}

extension TicketDetailViewController: PanModalPresentable {
    var showDragIndicator: Bool {
        return false
    }

    var panScrollable: UIScrollView? {
        return nil
    }

    var longFormHeight: PanModalHeight {
        return .maxHeightWithTopInset(343)
    }

    var anchorModalToLongForm: Bool {
        return true
    }
}

struct TicketDetialVC_Previews: PreviewProvider {
    static var previews: some View {
        TicketDetailViewController()
            .getRepresentable()
            .edgesIgnoringSafeArea(.all)
    }
}
