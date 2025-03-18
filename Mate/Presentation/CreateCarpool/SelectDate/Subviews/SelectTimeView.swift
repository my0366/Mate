//
//  MenuStackView.swift
//  Mate
//
//  Created by Jae Kyeong Ko on 2022/12/07.
//

import UIKit

import RxSwift
import SnapKit

final class SelectTimeView: UIStackView {
    private lazy var dayStatusStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        return stackView
    }()
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "오전/오후"
        label.font = UIFont.instance(name: .notoSansKRRegular, size: 13)
        label.textColor = UIColor(colorSet: .shadeBlack)
        return label
    }()
    lazy var dropDownButton: DropDownButton = {
        let dropDownButton = DropDownButton()
        dropDownButton.textFieldText = "오전"
        return dropDownButton
    }()
    private lazy var timeFormView: InfoFormView = {
        let infoFormView = InfoFormView()
        infoFormView.titleLabelText = "출발 시간"
        infoFormView.textFieldPlaceHolder = "HH:MM, 예: 08:30"
        return infoFormView
    }()

    var dropDownButtonText: String? {
        get {
            return dropDownButton.textFieldText
        }
        set {
            dropDownButton.textFieldText = newValue
        }
    }
    var dropDownButtonRx: Reactive<DropDownButton> {
        return dropDownButton.rx
    }
    var timeTextFieldText: String? {
        return timeFormView.textFieldText
    }
    var timeTextFieldRx: Reactive<UITextField> {
        return timeFormView.textFieldRx
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }

    required init(coder: NSCoder) {
        super.init(coder: coder)
    }

    func hideKeyboard() {
        timeFormView.hideKeyboard()
    }
}

private extension SelectTimeView {
    func configure() {
        configureViews()
        configureConstraints()
    }

    func configureViews() {
        spacing = 24

        [titleLabel, dropDownButton].forEach {
            dayStatusStackView.addArrangedSubview($0)
        }

        [dayStatusStackView, timeFormView].forEach {
            addArrangedSubview($0)
        }
    }

    func configureConstraints() {
        dropDownButton.snp.makeConstraints { make in
            make.height.equalTo(50)
        }

        dayStatusStackView.snp.makeConstraints { make in
            make.width.equalTo(106)
        }
    }
}
