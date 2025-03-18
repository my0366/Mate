//
//  ProfileImageViewController.swift
//  Mate
//
//  Created by Jae Kyeong Ko on 2022/11/18.
//

import PhotosUI
import UIKit

import RxCocoa
import RxSwift
import SnapKit

protocol ProfileImageViewControllerDelegate {
    func pushToDayChoice()
    func popToUserType()
}

final class ProfileImageViewController: UIViewController {
    private let disposeBag = DisposeBag()

    private let imageViewHeight: CGFloat = 80

    var delegate: ProfileImageViewControllerDelegate?
    var profileImage: UIImage?

    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "프로필 사진을 설정해주세요."
        label.font = UIFont.instance(name: .notoSansKRBold, size: 22)
        label.textColor = UIColor(colorSet: .shadeBlack)
        return label
    }()
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .leading
        stackView.spacing = 8
        return stackView
    }()
    private lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.text = "미설정시, 기본이미지로 자동설정됩니다."
        label.font = UIFont.instance(name: .notoSansKRRegular, size: 12)
        label.textColor = UIColor(colorSet: .neutral50)
        return label
    }()
    private lazy var selectImageButton: UIButton = {
        let button = UIButton()
        var config = UIButton.Configuration.filled()
        config.baseBackgroundColor = UIColor(colorSet: .neutral20)
        config.image = UIImage(imageSet: .plus)?.resizedImage(size: CGSize(width: 16, height: 16))
        config.cornerStyle = .capsule
        button.configuration = config
        return button
    }()
    private lazy var nextButton: RoundedButton = {
        let button = RoundedButton()
        button.title = "다음"
        return button
    }()
    private lazy var imagePicker: PHPickerViewController = {
        var config = PHPickerConfiguration()
        config.filter = .images
        config.selectionLimit = 1
        let picker = PHPickerViewController(configuration: config)
        return picker
    }()
    private lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.cornerRadius = imageViewHeight / 2
        imageView.layer.masksToBounds = true
        return imageView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
        bind()
    }

    private func bind() {
        selectImageButton.rx.tap
            .subscribe(onNext: { [weak self] in
                guard let self = self else { return }
                self.present(self.imagePicker, animated: true)
            })
            .disposed(by: disposeBag)

        nextButton.rx.tap
            .bind(onNext: { [weak self] in
                self?.delegate?.pushToDayChoice()
            })
            .disposed(by: disposeBag)
    }

    @objc
    private func didBackBarButtonTapped() {
        delegate?.popToUserType()
    }
}

private extension ProfileImageViewController {
    func configure() {
        configureViews()
        configureBarButton()
        configureConstraints()
        configureDelegates()
    }

    func configureViews() {
        view.backgroundColor = UIColor(colorSet: .background)

        [descriptionLabel, selectImageButton].forEach {
            stackView.addArrangedSubview($0)
        }

        [titleLabel, stackView, nextButton].forEach {
            view.addSubview($0)
        }
    }

    func configureBarButton() {
        let backBarButton = UIBarButtonItem(image: UIImage(imageSet: .arrowLeft),
                                            style: .done, target: self,
                                            action: #selector(didBackBarButtonTapped))

        navigationItem.leftBarButtonItem = backBarButton
    }

    func configureConstraints() {
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(30)
            make.leading.equalToSuperview().offset(16)
        }

        stackView.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(30)
            make.leading.trailing.equalToSuperview().inset(16)
        }

        selectImageButton.snp.makeConstraints { make in
            make.width.height.equalTo(80)
        }

        imageView.snp.makeConstraints { make in
            make.width.height.equalTo(imageViewHeight)
        }

        nextButton.snp.makeConstraints { make in
            make.bottom.equalTo(view.safeAreaLayoutGuide).offset(-10)
            make.leading.trailing.equalToSuperview().inset(16)
            make.height.equalTo(50)
        }
    }

    func configureDelegates() {
        imagePicker.delegate = self
    }
}

extension ProfileImageViewController: PHPickerViewControllerDelegate {
    func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
        picker.dismiss(animated: true)
        if let itemProvider = results.first?.itemProvider,
           itemProvider.canLoadObject(ofClass: UIImage.self) {
            itemProvider.loadObject(ofClass: UIImage.self) { [weak self] image, error in
                self?.profileImage = image as? UIImage
                DispatchQueue.main.async {
                    self?.selectImageButton.removeFromSuperview()
                    self?.stackView.addArrangedSubview(self?.imageView ?? UIView())
                    self?.imageView.image = image as? UIImage
                }
            }
        }
    }
}
