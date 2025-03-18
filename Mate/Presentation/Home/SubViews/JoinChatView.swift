//
//  JoinChatView.swift
//  Mate
//
//  Created by 성제 on 2022/12/12.
//

import Foundation
import UIKit
import SnapKit

class JoinChatView: UIView {

    private lazy var kakaoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.masksToBounds = true
        imageView.image = UIImage(named: ImageSet.kakaoTalk.rawValue)
        return imageView
    }()
    private lazy var chatLabel: UILabel = {
        let label = UILabel()
        label.text = "오픈카톡 참여하기"
        label.font = UIFont.instance(name: .notoSansKRRegular, size: 14)
        label.textColor = UIColor(colorSet: .shadeBlack)
        return label
    }()
    private lazy var arrowRightImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.masksToBounds = true
        imageView.image = UIImage(named: ImageSet.arrowRight.rawValue)
        return imageView
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension JoinChatView {

    func configure() {
        configureViews()
        configureConstraints()
    }

    func configureViews() {
        [kakaoImageView,
        chatLabel,
        arrowRightImageView].forEach { view in
            addSubview(view)
        }
    }

    func configureConstraints() {
        kakaoImageView.snp.makeConstraints { make in
            make.top.bottom.leading.equalToSuperview().inset(8)
            make.width.equalTo(22)
            make.height.equalTo(20)
        }

        chatLabel.snp.makeConstraints { make in
            make.leading.equalTo(kakaoImageView.snp.trailing).offset(8)
            make.top.bottom.equalToSuperview().inset(8)
            make.trailing.equalTo(arrowRightImageView.snp.leading)
        }

        arrowRightImageView.snp.makeConstraints { make in
            make.top.trailing.equalToSuperview().inset(12)
        }
    }
}
