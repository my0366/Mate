//
//  InfoView.swift
//  Mate
//
//  Created by Jae Kyeong Ko on 2022/11/17.
//

import UIKit

import RxSwift
import SnapKit

final class InfoFormView: UIView {
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        return stackView
    }()
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.instance(name: .notoSansKRRegular, size: 13)
        label.textColor = UIColor(colorSet: .shadeBlack)
        return label
    }()
    private lazy var textField: UITextField = {
        let textField = UITextField()
        textField.font = UIFont.instance(name: .notoSansKRRegular, size: 18)
        textField.textColor = UIColor(colorSet: .shadeBlack)
        textField.layer.borderWidth = 1
        textField.layer.borderColor = UIColor(colorSet: .shadeGray)?.cgColor
        textField.layer.cornerRadius = 4
        textField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 12, height: 0))
        textField.leftViewMode = .always
        textField.backgroundColor = .white
        return textField
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    var titleLabelText = "" {
        didSet {
            titleLabel.text = titleLabelText
        }
    }
    var textFieldPlaceHolder = "" {
        didSet {
            textField.placeholder = textFieldPlaceHolder
        }
    }
    var textFieldKeyBoardType = UIKeyboardType.default {
        didSet {
            textField.keyboardType = textFieldKeyBoardType
        }
    }
    var textFieldInputAccessoryView = UIView() {
        didSet {
            textField.inputAccessoryView = textFieldInputAccessoryView
        }
    }

    var textFieldText: String? {
        get {
            return textField.text
        }
        set {
            textField.text = newValue
        }
    }
    var textFieldRx: Reactive<UITextField> {
        return textField.rx
    }

    func showKeyboard() {
        textField.becomeFirstResponder()
    }

    func hideKeyboard() {
        textField.resignFirstResponder()
    }
}

private extension InfoFormView {
    func configure() {
        configureViews()
        configureConstraints()
    }

    func configureViews() {
        [titleLabel, textField].forEach {
            stackView.addArrangedSubview($0)
        }

        [stackView].forEach {
            addSubview($0)
        }
    }

    func configureConstraints() {
        stackView.snp.makeConstraints { make in
            make.top.bottom.leading.trailing.equalToSuperview()
        }

        titleLabel.snp.makeConstraints { make in
            make.top.leading.equalToSuperview()
        }

        textField.snp.makeConstraints { make in
            make.width.equalToSuperview()
            make.height.equalTo(50)
        }
    }
}
