//
//  ProfileUserTypeView.swift
//  Mate
//
//  Created by 성제 on 2022/12/07.
//

import UIKit
import SnapKit

class ProfileUserTypeView: UIView {

    var date: String? { didSet { bind() } }
    var type: String? { didSet { bind() } }

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    private lazy var dateOfUse: UILabel = {
        let label = UILabel()
        label.text = "사용 요일"
        label.font = UIFont.instance(name: .notoSansKRBold, size: 16)
        label.textColor = UIColor(colorSet: .shadeBlack)
        return label
    }()
    private lazy var userType: UILabel = {
        let label = UILabel()
        label.text = "사용자 유형"
        label.font = UIFont.instance(name: .notoSansKRBold, size: 16)
        label.textColor = UIColor(colorSet: .shadeBlack)
        return label
    }()
    private lazy var dateOfUseData: UILabel = {
        let label = UILabel()
        label.text = date
        label.font = UIFont.instance(name: .notoSansKRRegular, size: 16)
        label.textColor = UIColor(colorSet: .shadeBlack)
        return label
    }()
    private lazy var userTypeData: UILabel = {
        let label = UILabel()
        label.text = type
        label.font = UIFont.instance(name: .notoSansKRRegular, size: 16)
        label.textColor = UIColor(colorSet: .shadeBlack)
        return label
    }()
}

extension ProfileUserTypeView {

    func bind() {
        dateOfUseData.text = date
        userTypeData.text = type
    }

    func configure() {
        configureViews()
        configureConstraints()
    }

    func configureViews() {
        [dateOfUse,
         dateOfUseData,
         userType,
         userTypeData].forEach { view in
            addSubview(view)
        }
    }

    func configureConstraints() {
        dateOfUse.snp.makeConstraints { make in
            make.leading.equalTo(16)
            make.top.equalTo(17)
        }

        dateOfUseData.snp.makeConstraints { make in
            make.top.equalTo(17)
            make.trailing.equalToSuperview().inset(16)
        }

        userType.snp.makeConstraints { make in
            make.top.equalTo(dateOfUse.snp.bottom).offset(10)
            make.leading.equalTo(16)
        }

        userTypeData.snp.makeConstraints { make in
            make.bottom.equalToSuperview().inset(16)
            make.trailing.equalToSuperview().inset(16)
        }
    }
}
