//
//  SelectLocationView.swift
//  Mate
//
//  Created by Jae Kyeong Ko on 2022/11/28.
//

import UIKit

import RxSwift

final class StartAreaView: UIStackView {
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "출발지역"
        label.font = UIFont.instance(name: .notoSansKRRegular, size: 13)
        label.textColor = UIColor(colorSet: .shadeBlack)
        return label
    }()
    private lazy var startAreaDropDownButton = StartAreaDropDownButton()

    var startArea: String? {
        get {
            startAreaDropDownButton.textFieldText
        }
        set {
            startAreaDropDownButton.textFieldText = newValue
        }
    }
    var delegate: StartAreaDropDownButtonDelegate? {
        didSet {
            startAreaDropDownButton.delegate = delegate
        }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }

    required init(coder: NSCoder) {
        super.init(coder: coder)
    }

    func checkTextFieldIsEmpty() -> Bool {
        return startAreaDropDownButton.checkTextFieldIsEmpty()
    }
}

private extension StartAreaView {
    func configure() {
        axis = .vertical

        [titleLabel, startAreaDropDownButton].forEach {
            addArrangedSubview($0)
        }
    }
}
