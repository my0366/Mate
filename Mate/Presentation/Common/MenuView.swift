//
//  MenuView.swift
//  Mate
//
//  Created by Jae Kyeong Ko on 2022/11/29.
//

import UIKit

import SnapKit

protocol MenuViewDelegate {
    func didMenuButtonTapped(_ sender: UIButton)
}

final class MenuView: UIStackView {
    var delegate: MenuViewDelegate?

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }

    required init(coder: NSCoder) {
        super.init(coder: coder)
    }

    @objc
    private func didTapped(_ sender: UIButton) {
        delegate?.didMenuButtonTapped(sender)
    }

    func makeButton(with items: [String]) {
        for (index, area) in items.enumerated() {
            configureButtons(index: index, area: area)
        }
    }

    func hideMenuView() {
        snp.removeConstraints()
        removeFromSuperview()
    }

    func showMenuView(on superView: UIView, below view: UIView) {
        superView.addSubview(self)
        snp.makeConstraints { make in
            make.top.equalTo(view.snp.bottom)
            make.leading.trailing.equalTo(view)
        }
    }
}

private extension MenuView {
    func configure() {
        configureViews()
    }

    func configureViews() {
        axis = .vertical
        distribution = .fillEqually
        backgroundColor = .white
        layer.borderWidth = 1
        layer.borderColor = UIColor.white.cgColor
        layer.shadowOpacity = 0.08
        layer.shadowOffset = CGSize(width: 0, height: 4)
        layer.shadowColor = UIColor(white: 0.16, alpha: 1).cgColor
    }

    func configureButtons(index: Int, area: String) {
        let button = UIButton()
        var config = UIButton.Configuration.plain()
        var title = AttributedString(area)
        title.font = UIFont.instance(name: .notoSansKRRegular, size: 16)
        title.foregroundColor = UIColor(colorSet: .neutral50)
        config.attributedTitle = title
        config.titleAlignment = .leading
        button.configuration = config
        button.contentHorizontalAlignment = .leading
        button.tag = index
        button.addTarget(self, action: #selector(didTapped), for: .touchUpInside)
        addArrangedSubview(button)
    }
}
