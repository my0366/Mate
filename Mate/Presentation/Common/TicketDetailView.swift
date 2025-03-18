//
//  TicketDetailView.swift
//  Mate
//
//  Created by Jae Kyeong Ko on 2022/12/09.
//

import UIKit

import SnapKit

final class TicketDetailView: UIView {
    private lazy var startAreaStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 2
        stackView.layer.borderWidth = 1
        stackView.layer.borderColor = UIColor(colorSet: .neutral30)?.cgColor
        stackView.layer.cornerRadius = 4
        stackView.layoutMargins = UIEdgeInsets(top: 8, left: 12, bottom: 8, right: 12)
        stackView.isLayoutMarginsRelativeArrangement = true
        return stackView
    }()
    private lazy var startAreaTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "출발지"
        label.font = UIFont.instance(name: .notoSansKRBold, size: 13)
        label.textColor = UIColor(colorSet: .neutral50)
        return label
    }()
    private lazy var startAreaDetailLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.instance(name: .notoSansKRRegular, size: 14)
        label.textColor = UIColor(colorSet: .shadeBlack)
        return label
    }()
    private lazy var carImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(imageSet: .car))
        imageView.backgroundColor = UIColor(colorSet: .background)
        return imageView
    }()
    private lazy var dottedArrowImageView = UIImageView(image: UIImage(imageSet: .dottedArrow))
    private lazy var endAreaStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 2
        stackView.layer.borderWidth = 1
        stackView.layer.borderColor = UIColor(colorSet: .neutral30)?.cgColor
        stackView.layer.cornerRadius = 4
        stackView.layoutMargins = UIEdgeInsets(top: 8, left: 12, bottom: 8, right: 12)
        stackView.isLayoutMarginsRelativeArrangement = true
        return stackView
    }()
    private lazy var endAreaTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "도착지"
        label.font = UIFont.instance(name: .notoSansKRBold, size: 13)
        label.textColor = UIColor(colorSet: .neutral50)
        return label
    }()
    private lazy var endAreaDetailLabel: UILabel = {
        let label = UILabel()
        label.text = "경운대학교"
        label.font = UIFont.instance(name: .notoSansKRRegular, size: 14)
        label.textColor = UIColor(colorSet: .shadeBlack)
        return label
    }()
    private lazy var driverStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.spacing = 9
        return stackView
    }()
    private lazy var driverProfileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(imageSet: .gear)
        imageView.layer.cornerRadius = 22
        return imageView
    }()
    private lazy var nameStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        return stackView
    }()
    private lazy var driverTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "드라이버"
        label.font = UIFont.instance(name: .notoSansKRBold, size: 12)
        label.textColor = UIColor(colorSet: .neutral50)
        return label
    }()
    private lazy var driverNameLabel: UILabel = {
        let label = UILabel()
        label.text = "{ 이름 }"
        label.font = UIFont.instance(name: .notoSansKRRegular, size: 14)
        label.textColor = UIColor(colorSet: .shadeBlack)
        return label
    }()
    private lazy var accessoryImageView = UIImageView(image: UIImage(imageSet: .arrowRight))
    private lazy var infoContainerStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.spacing = 20
        return stackView
    }()
    private lazy var infoTopStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.distribution = .fillEqually
        return stackView
    }()
    private lazy var infoBottomStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.distribution = .fillEqually
        return stackView
    }()
    private lazy var timeStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        return stackView
    }()
    private lazy var timeTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "출발 시간"
        label.font = UIFont.instance(name: .notoSansKRBold, size: 12)
        label.textColor = UIColor(colorSet: .neutral50)
        return label
    }()
    private lazy var timeDetailLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.instance(name: .notoSansKRRegular, size: 14)
        label.textColor = UIColor(colorSet: .shadeBlack)
        return label
    }()
    private lazy var boardingPlaceStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        return stackView
    }()
    private lazy var boardingPlaceTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "탑승 장소"
        label.font = UIFont.instance(name: .notoSansKRBold, size: 12)
        label.textColor = UIColor(colorSet: .neutral50)
        return label
    }()
    private lazy var boardingPlaceDetailLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.instance(name: .notoSansKRRegular, size: 14)
        label.textColor = UIColor(colorSet: .shadeBlack)
        return label
    }()
    private lazy var numberOfPeopleStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        return stackView
    }()
    private lazy var numberOfPeopleTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "탑승 인원"
        label.font = UIFont.instance(name: .notoSansKRBold, size: 12)
        label.textColor = UIColor(colorSet: .neutral50)
        return label
    }()
    private lazy var numberOfPeopleDetailLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.instance(name: .notoSansKRRegular, size: 14)
        label.textColor = UIColor(colorSet: .shadeBlack)
        return label
    }()
    private lazy var costStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        return stackView
    }()
    private lazy var costTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "비용"
        label.font = UIFont.instance(name: .notoSansKRBold, size: 12)
        label.textColor = UIColor(colorSet: .neutral50)
        return label
    }()
    private lazy var costDetailLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.instance(name: .notoSansKRRegular, size: 14)
        label.textColor = UIColor(colorSet: .shadeBlack)
        return label
    }()

    var startAreaText: String? {
        didSet {
            startAreaDetailLabel.text = startAreaText
        }
    }
    var timeText: String? {
        didSet {
            timeDetailLabel.text = timeText
        }
    }
    var boardingPlaceText: String? {
        didSet {
            boardingPlaceDetailLabel.text = boardingPlaceText
        }
    }
    var numberOfPeopleText: String? {
        didSet {
            numberOfPeopleDetailLabel.text = numberOfPeopleText
        }
    }
    var costText: String? {
        didSet {
            if costText == CarpoolCost.free.rawValue {
                costDetailLabel.textColor = UIColor(colorSet: .primary50)
            } else {
                costDetailLabel.textColor = UIColor(colorSet: .red50)
            }
            costDetailLabel.text = costText
        }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
}

private extension TicketDetailView {
    func configure() {
        configureViews()
        configureConstraints()
    }

    func configureViews() {
        [startAreaTitleLabel, startAreaDetailLabel].forEach {
            startAreaStackView.addArrangedSubview($0)
        }

        [endAreaTitleLabel, endAreaDetailLabel].forEach {
            endAreaStackView.addArrangedSubview($0)
        }

        dottedArrowImageView.addSubview(carImageView)

        [driverTitleLabel, driverNameLabel].forEach {
            nameStackView.addArrangedSubview($0)
        }

        [driverProfileImageView, nameStackView].forEach {
            driverStackView.addArrangedSubview($0)
        }

        [timeTitleLabel, timeDetailLabel].forEach {
            timeStackView.addArrangedSubview($0)
        }

        [boardingPlaceTitleLabel, boardingPlaceDetailLabel].forEach {
            boardingPlaceStackView.addArrangedSubview($0)
        }

        [numberOfPeopleTitleLabel, numberOfPeopleDetailLabel].forEach {
            numberOfPeopleStackView.addArrangedSubview($0)
        }

        [costTitleLabel, costDetailLabel].forEach {
            costStackView.addArrangedSubview($0)
        }

        [timeStackView, boardingPlaceStackView].forEach {
            infoTopStackView.addArrangedSubview($0)
        }

        [numberOfPeopleStackView, costStackView].forEach {
            infoBottomStackView.addArrangedSubview($0)
        }

        [infoTopStackView, infoBottomStackView].forEach {
            infoContainerStackView.addArrangedSubview($0)
        }

        [startAreaStackView,
         dottedArrowImageView,
         endAreaStackView,
         driverStackView,
         accessoryImageView,
         infoContainerStackView].forEach {
            addSubview($0)
        }
    }

    func configureConstraints() {
        startAreaStackView.snp.makeConstraints { make in
            make.top.leading.equalToSuperview()
            make.width.equalTo(120)
        }

        dottedArrowImageView.snp.makeConstraints { make in
            make.centerY.equalTo(startAreaStackView)
            make.leading.equalTo(startAreaStackView.snp.trailing).offset(15)
        }

        carImageView.snp.makeConstraints { make in
            make.center.equalTo(dottedArrowImageView)
        }

        endAreaStackView.snp.makeConstraints { make in
            make.top.trailing.equalToSuperview()
            make.leading.equalTo(dottedArrowImageView.snp.trailing).offset(15)
            make.width.equalTo(120)
        }

        driverStackView.snp.makeConstraints { make in
            make.top.equalTo(startAreaStackView.snp.bottom).offset(20)
            make.leading.equalToSuperview()
        }

        accessoryImageView.snp.makeConstraints { make in
            make.centerY.equalTo(driverStackView)
            make.leading.equalTo(driverStackView.snp.trailing)
            make.trailing.equalToSuperview()
            make.width.equalTo(7.5)
        }

        infoContainerStackView.snp.makeConstraints { make in
            make.top.equalTo(driverStackView.snp.bottom).offset(20)
            make.leading.trailing.equalToSuperview()
        }

        driverProfileImageView.snp.makeConstraints { make in
            make.width.height.equalTo(44)
        }
    }
}
