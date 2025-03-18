//
//  ProfileUserDataView.swift
//  Mate
//
//  Created by 성제 on 2022/12/07.
//

import UIKit
import SnapKit

class ProfileUserDataView: UIView {

    var memberName: String? { didSet { bind() } }
    var studentNumber: String? { didSet { bind() } }
    var department: String? { didSet { bind() } }
    var phoneNumber: String? { didSet { bind() } }

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    private let imageViewHeight: CGFloat = 80

    private lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.cornerRadius = imageViewHeight / 2
        imageView.layer.masksToBounds = true
        imageView.backgroundColor = .blue
        return imageView
    }()

    private lazy var userName: UILabel = {
        let label = UILabel()
        label.text = "이름"
        label.font = UIFont.instance(name: .notoSansKRBold, size: 16)
        label.textColor = UIColor(colorSet: .shadeBlack)
        return label
    }()
    private lazy var userStudentID: UILabel = {
        let label = UILabel()
        label.text = "학번"
        label.font = UIFont.instance(name: .notoSansKRBold, size: 16)
        label.textColor = UIColor(colorSet: .shadeBlack)
        return label
    }()
    private lazy var userDepartment: UILabel = {
        let label = UILabel()
        label.text = "학과"
        label.font = UIFont.instance(name: .notoSansKRBold, size: 16)
        label.textColor = UIColor(colorSet: .shadeBlack)
        return label
    }()
    private lazy var userPhoneNumber: UILabel = {
        let label = UILabel()
        label.text = "휴대폰 번호"
        label.font = UIFont.instance(name: .notoSansKRBold, size: 16)
        label.textColor = UIColor(colorSet: .shadeBlack)
        return label
    }()
    private lazy var userNameData: UILabel = {
        let label = UILabel()
        label.text = memberName
        label.font = UIFont.instance(name: .notoSansKRRegular, size: 16)
        label.textColor = UIColor(colorSet: .shadeBlack)
        return label
    }()
    private lazy var userStudentIDData: UILabel = {
        let label = UILabel()
        label.text = studentNumber
        label.font = UIFont.instance(name: .notoSansKRRegular, size: 16)
        label.textColor = UIColor(colorSet: .shadeBlack)
        return label
    }()
    private lazy var userDepartmentData: UILabel = {
        let label = UILabel()
        label.text = department
        label.font = UIFont.instance(name: .notoSansKRRegular, size: 16)
        label.textColor = UIColor(colorSet: .shadeBlack)
        return label
    }()
    private lazy var userPhoneNumberData: UILabel = {
        let label = UILabel()
        label.text = phoneNumber
        label.font = UIFont.instance(name: .notoSansKRRegular, size: 16)
        label.textColor = UIColor(colorSet: .shadeBlack)
        return label
    }()
}

extension ProfileUserDataView {

    func bind() {
        userNameData.text = memberName
        userStudentIDData.text = studentNumber
        userDepartmentData.text = department
        userPhoneNumberData.text = phoneNumber
    }

    func configure() {
        configureViews()
        configureConstraints()
    }

    func configureViews() {
        [imageView,
         userName,
          userNameData,
          userStudentID,
          userStudentIDData,
          userDepartment,
          userDepartmentData,
          userPhoneNumber,
          userPhoneNumberData].forEach { view in
            addSubview(view)
        }
        imageView.backgroundColor = .gray
    }

    func configureConstraints() {
        imageView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(16)
            make.width.height.equalTo(imageViewHeight)
        }

        userName.snp.makeConstraints { make in
            make.leading.equalTo(20)
            make.top.equalTo(imageView.snp.bottom).offset(8)
        }

        userNameData.snp.makeConstraints { make in
            make.top.equalTo(imageView.snp.bottom).offset(8)
            make.trailing.equalToSuperview().inset(20)
        }

        userStudentID.snp.makeConstraints { make in
            make.top.equalTo(userName.snp.bottom).offset(10)
            make.leading.equalTo(20)
        }

        userStudentIDData.snp.makeConstraints { make in
            make.top.equalTo(userName.snp.bottom).offset(10)
            make.trailing.equalToSuperview().inset(20)
        }

        userDepartment.snp.makeConstraints { make in
            make.top.equalTo(userStudentID.snp.bottom).offset(10)
            make.leading.equalTo(20)
        }

        userDepartmentData.snp.makeConstraints { make in
            make.top.equalTo(userStudentID.snp.bottom).offset(10)
            make.trailing.equalToSuperview().inset(20)
        }

        userPhoneNumber.snp.makeConstraints { make in
            make.top.equalTo(userDepartment.snp.bottom).offset(10)
            make.leading.equalTo(20)
        }

        userPhoneNumberData.snp.makeConstraints { make in
            make.top.equalTo(userDepartmentData.snp.bottom).offset(10)
            make.trailing.equalToSuperview().inset(20)
        }
    }
}
