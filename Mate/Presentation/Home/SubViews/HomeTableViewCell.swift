//
//  HomeTableViewCell.swift
//  Mate
//
//  Created by Jae Kyeong Ko on 2022/11/25.
//

import UIKit
import SnapKit

final class HomeTableViewCell: UITableViewCell {

    public var profileImageView: UIImageView = {
        let imgView = UIImageView()
        imgView.layer.cornerRadius = 22
        imgView.backgroundColor = .darkGray
        return imgView
    }()
    public lazy var recruitPersonLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.instance(name: .notoSansKRRegular, size: 12)
        label.layer.cornerRadius = 12
        label.textAlignment = .center
        label.clipsToBounds = true
        label.textColor = .white
        return label
    }()
    public lazy var recruitTimeLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.instance(name: .notoSansKRBold, size: 16)
        label.textColor = UIColor(colorSet: .shadeBlack)
        return label
    }()
    public lazy var recruitAreaLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.instance(name: .notoSansKRBold, size: 16)
        label.textColor = UIColor(colorSet: .shadeBlack)
        return label
    }()
    public lazy var recruitInformationDefaultLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.instance(name: .notoSansKRRegular, size: 16)
        label.textColor = UIColor(colorSet: .shadeBlack)
        return label
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configure()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        configure()
    }

    func configure() {
        configureViews()
        configureConstraints()
    }

    func configureViews() {
        contentView.addSubview(profileImageView)
        contentView.addSubview(recruitPersonLabel)
        contentView.addSubview(recruitTimeLabel)
        contentView.addSubview(recruitAreaLabel)
        contentView.addSubview(recruitInformationDefaultLabel)
    }

    func configureConstraints() {
        profileImageView.snp.makeConstraints { make in
            make.width.height.equalTo(44)
            make.top.leading.bottom.equalToSuperview().inset(16)
        }

        recruitAreaLabel.snp.makeConstraints { make in
            make.leading.equalTo(profileImageView.snp.trailing).offset(5)
            make.top.bottom.equalToSuperview().inset(26)
        }

        recruitInformationDefaultLabel.snp.makeConstraints { make in
            make.leading.equalTo(recruitAreaLabel.snp.trailing).offset(2)
            make.top.bottom.equalToSuperview().inset(26)
        }

        recruitTimeLabel.snp.makeConstraints { make in
            make.leading.equalTo(recruitInformationDefaultLabel.snp.trailing).offset(2)
            make.top.bottom.equalToSuperview().inset(26)
        }

        recruitPersonLabel.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview().inset(26)
            make.trailing.equalToSuperview().inset(16)
            make.width.equalTo(44)
        }
    }
}
