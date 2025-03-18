//
//  ProgressStackView.swift
//  Mate
//
//  Created by Jae Kyeong Ko on 2022/11/28.
//

import UIKit

final class ProgressStackView: UIStackView {
    private lazy var progressView1 = UIImageView(image: UIImage(imageSet: .barEmpty))
    private lazy var progressView2 = UIImageView(image: UIImage(imageSet: .barEmpty))
    private lazy var progressView3 = UIImageView(image: UIImage(imageSet: .barEmpty))

    var progressImage1: UIImage = UIImage(imageSet: .barEmpty) ?? UIImage() {
        didSet {
            progressView1.image = progressImage1
        }
    }

    var progressImage2: UIImage = UIImage(imageSet: .barEmpty) ?? UIImage() {
        didSet {
            progressView2.image = progressImage2
        }
    }

    var progressImage3: UIImage = UIImage(imageSet: .barEmpty) ?? UIImage() {
        didSet {
            progressView3.image = progressImage3
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

private extension ProgressStackView {
    func configure() {
        axis = .horizontal
        spacing = 6
        distribution = .fillEqually

        [progressView1, progressView2, progressView3].forEach {
            addArrangedSubview($0)
        }
    }
}
