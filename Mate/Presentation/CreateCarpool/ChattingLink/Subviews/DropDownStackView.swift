//
//  DropDownStackView.swift
//  Mate
//
//  Created by Jae Kyeong Ko on 2022/12/08.
//

import UIKit

import RxSwift
import SnapKit

final class DropDownStackView: UIStackView {
    private lazy var peopleCountStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        return stackView
    }()
    private lazy var costStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        return stackView
    }()
    private lazy var peopleCountTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "탑승 인원"
        label.font = UIFont.instance(name: .notoSansKRRegular, size: 13)
        label.textColor = UIColor(colorSet: .shadeBlack)
        return label
    }()
    private lazy var costTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "탑승 비용"
        label.font = UIFont.instance(name: .notoSansKRRegular, size: 13)
        label.textColor = UIColor(colorSet: .shadeBlack)
        return label
    }()
    lazy var peopleCountDropDownButton: DropDownButton = {
        let dropDownButton = DropDownButton()
        dropDownButton.textFieldPlaceholder = "선택"
        return dropDownButton
    }()
    lazy var costDropDownButton: DropDownButton = {
        let dropDownButton = DropDownButton()
        dropDownButton.textFieldPlaceholder = "선택"
        return dropDownButton
    }()

    var peopleCountButtonRx: Reactive<DropDownButton> {
        return peopleCountDropDownButton.rx
    }
    var costButtonRx: Reactive<DropDownButton> {
        return costDropDownButton.rx
    }
    var peopleCountText: String? {
        get {
            return peopleCountDropDownButton.textFieldText
        }
        set {
            peopleCountDropDownButton.textFieldText = newValue
        }
    }
    var costText: String? {
        get {
            return costDropDownButton.textFieldText
        }
        set {
            if newValue == CarpoolCost.free.rawValue {
                costDropDownButton.textFieldTextColor = UIColor(colorSet: .primary50)
            } else {
                costDropDownButton.textFieldTextColor = UIColor(colorSet: .red50)
            }
            costDropDownButton.textFieldText = newValue
        }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }

    required init(coder: NSCoder) {
        super.init(coder: coder)
    }
}

private extension DropDownStackView {
    func configure() {
        configureViews()
        configureConstraints()
    }

    func configureViews() {
        spacing = 20
        distribution = .fillEqually

        [peopleCountTitleLabel, peopleCountDropDownButton].forEach {
            peopleCountStackView.addArrangedSubview($0)
        }

        [costTitleLabel, costDropDownButton].forEach {
            costStackView.addArrangedSubview($0)
        }

        [peopleCountStackView, costStackView].forEach {
            addArrangedSubview($0)
        }
    }

    func configureConstraints() {
        peopleCountDropDownButton.snp.makeConstraints { make in
            make.height.equalTo(50)
        }

        costDropDownButton.snp.makeConstraints { make in
            make.height.equalTo(50)
        }
    }
}
