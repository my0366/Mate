//
//  LocationDropDownView.swift
//  Mate
//
//  Created by Jae Kyeong Ko on 2022/11/29.
//

import UIKit

import RxSwift
import SnapKit

protocol StartAreaDropDownButtonDelegate {
    func didStartAreaDropDownButtonTapped()
}

final class StartAreaDropDownButton: UIButton {
    var delegate: StartAreaDropDownButtonDelegate?

    private lazy var locationImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(imageSet: .location)
        return imageView
    }()
    private lazy var textField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "출발 지역을 선택해주세요"
        textField.font = UIFont.instance(name: .notoSansKRRegular, size: 18)
        textField.textColor = UIColor(colorSet: .shadeBlack)
        textField.isEnabled = false
        return textField
    }()
    private lazy var accessoryImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(imageSet: .arrowBottom)
        return imageView
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    var textFieldRx: Reactive<UITextField> {
        return textField.rx
    }
    var textFieldText: String? {
        get {
            return textField.text
        }
        set {
            textField.text = newValue
        }
    }

    func checkTextFieldIsEmpty() -> Bool {
        guard let text = textField.text else { return false }

        return text.isEmpty
    }

    @objc
    private func didTapped(_ sender: UIButton) {
        delegate?.didStartAreaDropDownButtonTapped()
    }
}

private extension StartAreaDropDownButton {
    func configure() {
        configureViews()
        configureConstraints()
    }

    func configureViews() {
        isSelected = false
        backgroundColor = .white
        layer.cornerRadius = 4
        layer.borderWidth = 1
        layer.borderColor = UIColor(colorSet: .shadeGray)?.cgColor
        addTarget(self, action: #selector(didTapped(_:)), for: .touchUpInside)

        [locationImageView, textField, accessoryImageView].forEach {
            addSubview($0)
        }
    }

    func configureConstraints() {
        snp.makeConstraints { make in
            make.height.equalTo(50)
        }

        locationImageView.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalToSuperview().offset(12)
            make.width.height.equalTo(24)
        }

        textField.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalTo(locationImageView.snp.trailing).offset(12)
        }

        accessoryImageView.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalTo(textField.snp.trailing).offset(12)
            make.trailing.equalToSuperview().offset(-12)
            make.width.equalTo(12)
        }
    }
}
