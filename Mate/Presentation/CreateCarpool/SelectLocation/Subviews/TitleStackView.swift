//
//  TitleStackView.swift
//  Mate
//
//  Created by Jae Kyeong Ko on 2022/11/28.
//

import UIKit

final class TitleStackView: UIStackView {
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "출발지를 선택해주세요."
        label.font = UIFont.instance(name: .notoSansKRBold, size: 22)
        label.textColor = UIColor(colorSet: .shadeBlack)
        return label
    }()
    private lazy var subTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "도착지는 경운대학교로 자동 설정됩니다."
        label.font = UIFont.instance(name: .notoSansKRRegular, size: 12)
        label.textColor = UIColor(colorSet: .shadeBlack)
        return label
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }

    required init(coder: NSCoder) {
        super.init(coder: coder)
    }
}

private extension TitleStackView {
    func configure() {
        axis = .vertical

        [titleLabel, subTitleLabel].forEach {
            addArrangedSubview($0)
        }
    }
}
