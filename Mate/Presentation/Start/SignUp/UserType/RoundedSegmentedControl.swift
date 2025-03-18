//
//  RoundedSegmentedControl.swift
//  Mate
//
//  Created by Jae Kyeong Ko on 2022/11/18.
//

import UIKit

import SnapKit

final class RoundedSegmentedControl: UIView {
    var viewHeight: CGFloat = 0 {
        didSet {
            containerView.layer.cornerRadius = viewHeight / 2
        }
    }

    private lazy var containerView: UIView = {
        let view = UIView()

        view.backgroundColor = UIColor(colorSet: .background)
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor(colorSet: .primary50)?.cgColor
        view.clipsToBounds = true

        return view
    }()

    private lazy var stackView: UIStackView = {
        let stackView = UIStackView()

        stackView.axis = .horizontal

        return stackView
    }()

    lazy var driverButton: UIButton = {
        let button = UIButton()
        var config = UIButton.Configuration.filled()
        var title = AttributedString("드라이버")

        title.font = UIFont.instance(name: .notoSansKRBold, size: 16)
        config.attributedTitle = title
        config.baseForegroundColor = UIColor(colorSet: .primary50)
        config.baseBackgroundColor = UIColor(colorSet: .background)
        config.cornerStyle = .capsule
        button.configuration = config
        button.isSelected = false

        return button
    }()

    lazy var passengerButton: UIButton = {
        let button = UIButton()
        var config = UIButton.Configuration.filled()
        var title = AttributedString("패신저")

        title.font = UIFont.instance(name: .notoSansKRBold, size: 16)
        config.attributedTitle = title
        config.baseForegroundColor = .white
        config.baseBackgroundColor = UIColor(colorSet: .primary50)
        config.cornerStyle = .capsule
        button.configuration = config
        button.isSelected = true

        return button
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
}

private extension RoundedSegmentedControl {
    func configure() {
        configureViews()
        configureConstraints()
    }

    func configureViews() {
        [driverButton, passengerButton].forEach {
            stackView.addArrangedSubview($0)
        }

        [containerView, stackView].forEach {
            addSubview($0)
        }
    }

    func configureConstraints() {
        containerView.snp.makeConstraints { make in
            make.top.bottom.leading.trailing.equalToSuperview()
        }

        stackView.snp.makeConstraints { make in
            make.top.bottom.leading.trailing.equalTo(containerView).inset(3)
        }
    }
}
