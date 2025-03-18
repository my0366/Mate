//
//  BoxView.swift
//  Mate
//
//  Created by 성제 on 2022/12/12.
//

import Foundation
import UIKit

final class BoxStackView: UIStackView {

    var point: String? { didSet { bind() } }
    var destination: String? { didSet { bind() } }

    private lazy var pointLabel: UILabel = {
        let label = UILabel()
        label.text = point
        label.font = UIFont.instance(name: .notoSansKRBold, size: 13)
        label.textColor = UIColor(colorSet: .neutral50)
        return label
    }()

    private lazy var destinationLabel: UILabel = {
        let label = UILabel()
        label.text = destination
        label.font = UIFont.instance(name: .notoSansKRRegular, size: 14)
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

private extension BoxStackView {

    func configure() {
        axis = .vertical
        spacing = 4
        distribution = .fillEqually
        alignment = .leading
        [pointLabel, destinationLabel].forEach {
            addArrangedSubview($0)
        }
    }

    func bind() {
        pointLabel.text = point
        destinationLabel.text = destination
    }
}
