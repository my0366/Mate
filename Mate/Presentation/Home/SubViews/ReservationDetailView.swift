//
//  ReservationDetailView.swift
//  Mate
//
//  Created by 성제 on 2022/12/12.
//

import UIKit
import SnapKit

class ReservationDetailView: UIView {
    var boardingTime: String? { didSet { bind() } }
    var attendDestination: String? { didSet { bind() } }
    var numberOfPassengers: Int? { didSet { bind() } }
    var price: String? { didSet { bind() } }

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    private lazy var boardingTimeLabel: UILabel = {
        let label = UILabel()
        label.text = "출발 시간"
        label.font = UIFont.instance(name: .notoSansKRBold, size: 12)
        label.textColor = UIColor(colorSet: .neutral50)
        return label
    }()
    private lazy var attendDestinationLabel: UILabel = {
        let label = UILabel()
        label.text = "탑승 장소"
        label.font = UIFont.instance(name: .notoSansKRBold, size: 12)
        label.textColor = UIColor(colorSet: .neutral50)
        return label
    }()
    private lazy var numberOfPassengersLabel: UILabel = {
        let label = UILabel()
        label.text = "탑승 인원"
        label.font = UIFont.instance(name: .notoSansKRBold, size: 12)
        label.textColor = UIColor(colorSet: .neutral50)
        return label
    }()
    private lazy var priceLabel: UILabel = {
        let label = UILabel()
        label.text = "비용"
        label.font = UIFont.instance(name: .notoSansKRBold, size: 12)
        label.textColor = UIColor(colorSet: .neutral50)
        return label
    }()
    private lazy var boardingTimeField: UILabel = {
        let label = UILabel()
        label.text = boardingTime
        label.font = UIFont.instance(name: .notoSansKRRegular, size: 14)
        label.textColor = UIColor(colorSet: .shadeBlack)
        return label
    }()
    private lazy var attendDestinationField: UILabel = {
        let label = UILabel()
        label.text = attendDestination
        label.font = UIFont.instance(name: .notoSansKRRegular, size: 14)
        label.textColor = UIColor(colorSet: .shadeBlack)
        return label
    }()
    private lazy var numberOfPassengersField: UILabel = {
        let label = UILabel()
        label.text = ""
        label.font = UIFont.instance(name: .notoSansKRRegular, size: 14)
        label.textColor = UIColor(colorSet: .shadeBlack)
        return label
    }()
    private lazy var priceField: UILabel = {
        let label = UILabel()
        label.text = price
        label.font = UIFont.instance(name: .notoSansKRRegular, size: 14)
        label.textColor = UIColor(colorSet: .shadeBlack)
        return label
    }()
    private lazy var createStateButton: RoundedButton = {
        let button = RoundedButton()
        button.title = "생성한 카풀이 없습니다."
        button.baseForegroundColor = .white
        button.baseBackgroundColor = UIColor(colorSet: .shadeBlack)
        return button
    }()
}

extension ReservationDetailView {

    func bind() {
        boardingTimeField.text = boardingTime
        attendDestinationField.text = attendDestination
        numberOfPassengersField.text = "\(numberOfPassengers ?? 0)명"
        priceField.text = price

        if price == "유료" {
            self.priceField.textColor = UIColor(colorSet: .red60)
        } else {
            self.priceField.textColor = UIColor(colorSet: .primary60)
        }
    }
    func configure() {
        configureViews()
        configureConstraints()
    }

    func configureViews() {
        [boardingTimeLabel,
         boardingTimeField,
         attendDestinationLabel,
         attendDestinationField,
         numberOfPassengersLabel,
         numberOfPassengersField,
         priceLabel,
         priceField].forEach { view in
            addSubview(view)
        }

    }

    func configureConstraints() {
        boardingTimeLabel.snp.makeConstraints { make in
            make.top.leading.equalToSuperview()
            make.width.equalTo(167.5)
        }

        boardingTimeField.snp.makeConstraints { make in
            make.top.equalTo(boardingTimeLabel.snp.bottom)
            make.leading.equalToSuperview()
            make.width.equalTo(167.5)
        }

        attendDestinationLabel.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.equalTo(boardingTimeLabel.snp.trailing)
            make.trailing.equalToSuperview()
        }

        attendDestinationField.snp.makeConstraints { make in
            make.top.equalTo(attendDestinationLabel.snp.bottom)
            make.leading.equalTo(boardingTimeField.snp.trailing)
            make.trailing.equalToSuperview()
        }

        numberOfPassengersLabel.snp.makeConstraints { make in
            make.top.equalTo(boardingTimeField.snp.bottom).offset(20)
            make.leading.equalToSuperview()
            make.width.equalTo(167.5)
        }

        numberOfPassengersField.snp.makeConstraints { make in
            make.top.equalTo(numberOfPassengersLabel.snp.bottom)
            make.leading.equalToSuperview()
            make.width.equalTo(167.5)
        }

        priceLabel.snp.makeConstraints { make in
            make.top.equalTo(attendDestinationField.snp.bottom).offset(20)
            make.leading.equalTo(numberOfPassengersLabel.snp.trailing)
            make.trailing.equalToSuperview()
        }

        priceField.snp.makeConstraints { make in
            make.top.equalTo(priceLabel.snp.bottom)
            make.leading.equalTo(numberOfPassengersField.snp.trailing)
            make.trailing.equalToSuperview()
        }
    }
}
