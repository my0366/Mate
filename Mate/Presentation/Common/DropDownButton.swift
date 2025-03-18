//
//  DropDownButton.swift
//  Mate
//
//  Created by Jae Kyeong Ko on 2022/12/02.
//

import UIKit

import RxSwift
import SnapKit

final class DropDownButton: UIButton {
    private lazy var textField: UITextField = {
        let textField = UITextField()
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
    var textFieldPlaceholder: String = "" {
        didSet {
            textField.placeholder = textFieldPlaceholder
        }
    }
    var textFieldTextColor: UIColor? {
        didSet {
            textField.textColor = textFieldTextColor
        }
    }

    func checkTextFieldIsNotEmpty() -> Bool {
        guard let text = textField.text else { return false }

        return !text.isEmpty
    }
}

private extension DropDownButton {
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

        [textField, accessoryImageView].forEach {
            addSubview($0)
        }
    }

    func configureConstraints() {
        snp.makeConstraints { make in
            make.height.equalTo(50)
        }

        textField.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalToSuperview().offset(12)
        }

        accessoryImageView.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalTo(textField.snp.trailing).offset(12)
            make.trailing.equalToSuperview().offset(-12)
            make.width.equalTo(12)
        }
    }
}
