//
//  RoundedButton.swift
//  Mate
//
//  Created by Jae Kyeong Ko on 2022/11/17.
//

import UIKit

final class RoundedButton: UIButton {
    private var config = UIButton.Configuration.filled()

    var title = "" {
        didSet {
            var title = AttributedString(title)
            title.font = UIFont.instance(name: .notoSansKRBold, size: 18)
            config.attributedTitle = title
            configuration = config
        }
    }
    var baseForegroundColor: UIColor? {
        didSet {
            config.baseForegroundColor = baseForegroundColor
            configuration = config
        }
    }
    var baseBackgroundColor: UIColor? {
        didSet {
            config.baseBackgroundColor = baseBackgroundColor
            configuration = config
        }
    }
    var borderWidth: CGFloat = 0 {
        didSet {
            layer.cornerRadius = 25
            layer.borderColor = UIColor(colorSet: .primary50)?.cgColor
            layer.borderWidth = borderWidth
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

extension RoundedButton {
    private func configure() {
        config.baseBackgroundColor = UIColor(colorSet: .primary50)
        config.baseForegroundColor = .white
        config.cornerStyle = .capsule
    }
}
