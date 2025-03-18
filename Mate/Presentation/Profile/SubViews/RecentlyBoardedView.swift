//
//  RecentlyBoardedView.swift
//  Mate
//
//  Created by 성제 on 2022/12/07.
//

import UIKit
import SnapKit

class RecentlyBoardedView: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private lazy var recentlyBoardedLabel: UILabel = {
        let label = UILabel()
        label.text = "최근 탑승 목록"
        label.font = UIFont.instance(name: .notoSansKRBold, size: 16)
        label.textColor = UIColor(colorSet: .shadeBlack)
        return label
    }()
}

extension RecentlyBoardedView {

    func configure() {
        configureViews()
        configureConstraints()
    }

    func configureViews() {
        [recentlyBoardedLabel].forEach { view in
            addSubview(view)
        }
    }

    func configureConstraints() {
        recentlyBoardedLabel.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview().inset(16)
        }
    }
}
