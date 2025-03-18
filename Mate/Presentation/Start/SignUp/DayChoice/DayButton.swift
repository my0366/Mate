//
//  DayButton.swift
//  Mate
//
//  Created by Jae Kyeong Ko on 2022/11/18.
//

import UIKit

class DayButton: UIButton {
    private var config = UIButton.Configuration.filled()

    var title = "" {
        didSet {
            var title = AttributedString(title)
            title.font = UIFont.instance(name: .notoSansKRBold, size: 16)
            config.attributedTitle = title
            configuration = config
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

extension DayButton {
    private func configure() {
        isSelected = false
        config.baseForegroundColor = UIColor(colorSet: .shadeGray)
        config.baseBackgroundColor = UIColor(colorSet: .background)
        config.cornerStyle = .capsule
    }
}
