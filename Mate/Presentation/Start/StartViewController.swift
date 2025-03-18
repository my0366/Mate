//
//  ViewController.swift
//  Mate
//
//  Created by Jae Kyeong Ko on 2022/11/17.
//

import UIKit

import RxCocoa
import RxSwift
import SnapKit

protocol StartViewControllerDelegate {
    func pushToSignUp()
    func pushToLogin()
}

final class StartViewController: UIViewController {
    private let disposeBag = DisposeBag()

    var delegate: StartViewControllerDelegate?

    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 2
        label.text = "경운대학교\n카풀 서비스"
        label.font = UIFont.instance(name: .notoSansKRBold, size: 22)
        label.textColor = UIColor(colorSet: .shadeBlack)
        return label
    }()
    private lazy var carImageView = UIImageView(image: UIImage(imageSet: .car))
    private lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 2
        label.text = "간단하게 가입하고\n카풀 서비스를 이용해보세요"
        label.font = UIFont.instance(name: .notoSansKRRegular, size: 16)
        label.textColor = UIColor(colorSet: .shadeBlack)
        return label
    }()
    private lazy var checkHaveIdLabel: UILabel = {
        let label = UILabel()
        label.text = "이미 아이디가 있으신가요?"
        label.font = UIFont.instance(name: .notoSansKRRegular, size: 14)
        label.textColor = UIColor(colorSet: .shadeBlack)
        return label
    }()
    private lazy var loginButton: UIButton = {
        let button = UIButton()
        var config = UIButton.Configuration.plain()
        var title = AttributedString("로그인 하기")
        let attributeContainer = AttributeContainer(
            [NSAttributedString.Key.underlineStyle: NSUnderlineStyle.single.rawValue]
        )
        title.setAttributes(attributeContainer)
        title.font = UIFont.instance(name: .notoSansKRBold, size: 14)
        config.attributedTitle = title
        config.baseForegroundColor = UIColor(colorSet: .shadeGray)
        button.configuration = config
        return button
    }()
    private lazy var startButton: RoundedButton = {
        let button = RoundedButton()
        button.title = "시작하기"
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
        bind()
    }

    private func bind() {
        startButton.rx.tap
            .bind(onNext: { [weak self] in
                self?.delegate?.pushToSignUp()
            })
            .disposed(by: disposeBag)

        loginButton.rx.tap
            .bind(onNext: { [weak self] in
                self?.delegate?.pushToLogin()
            })
            .disposed(by: disposeBag)
    }
}

private extension StartViewController {
    func configure() {
        configureViews()
        configureConstraints()
    }

    func configureViews() {
        view.backgroundColor = UIColor(colorSet: .background)

        [titleLabel,
         carImageView,
         descriptionLabel,
         checkHaveIdLabel,
         loginButton,
         startButton].forEach {
            view.addSubview($0)
        }
    }

    func configureConstraints() {
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(89)
            make.leading.equalToSuperview().offset(16)
        }

        carImageView.snp.makeConstraints { make in
            make.leading.equalTo(titleLabel.snp.trailing).offset(7)
            make.bottom.equalTo(descriptionLabel.snp.top).offset(-26)
            make.width.equalTo(18)
            make.height.equalTo(16)
        }

        descriptionLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(20)
            make.leading.equalToSuperview().offset(16)
        }

        checkHaveIdLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalTo(loginButton.snp.top)
        }

        loginButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalTo(startButton.snp.top).offset(-18)
            make.width.equalTo(92)
            make.height.equalTo(22)
        }

        startButton.snp.makeConstraints { make in
            make.bottom.equalTo(view.safeAreaLayoutGuide).offset(-10)
            make.leading.trailing.equalToSuperview().inset(16)
            make.height.equalTo(50)
        }
    }
}
