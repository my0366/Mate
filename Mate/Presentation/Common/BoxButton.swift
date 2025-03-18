//
//  BoxButton.swift
//  Mate
//
//  Created by Jae Kyeong Ko on 2022/11/25.
//

import UIKit

import SnapKit

final class BoxButton: UIButton {
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 8
        stackView.isUserInteractionEnabled = false
        return stackView
    }()
    private lazy var iconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    private lazy var label: UILabel = {
        let label = UILabel()
        label.textColor = UIColor(colorSet: .shadeBlack)
        label.font = UIFont.instance(name: .notoSansKRBold, size: 16)
        return label
    }()
    private lazy var accessoryImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.tintColor = UIColor(colorSet: .shadeGray)
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()

    var title = "" {
        didSet {
            label.text = title
        }
    }
    var iconImage = UIImage() {
        didSet {
            iconImageView.image = iconImage
        }
    }
    var accessoryImage = UIImage() {
        didSet {
            accessoryImageView.image = accessoryImage
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

private extension BoxButton {
    func configure() {
        configureViews()
        configureConstraints()
    }

    func configureViews() {
        backgroundColor = .white
        layer.cornerRadius = 8
        layer.borderWidth = 1
        layer.borderColor = UIColor.white.cgColor
        layer.shadowOpacity = 0.08
        layer.shadowOffset = CGSize(width: 0, height: 4)
        layer.shadowColor = UIColor(white: 0.16, alpha: 1).cgColor
        layer.shadowRadius = 8
        layer.masksToBounds = false

        [iconImageView, label, accessoryImageView].forEach {
            stackView.addArrangedSubview($0)
        }

        addSubview(stackView)
    }

    func configureConstraints() {
        stackView.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.trailing.equalToSuperview().inset(16)
        }

        iconImageView.snp.makeConstraints { make in
            make.width.equalTo(24)
        }
    }
}
