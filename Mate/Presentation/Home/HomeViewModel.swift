//
//  HomeViewModel.swift
//  Mate
//
//  Created by Jae Kyeong Ko on 2022/12/23.
//

import Foundation

import RxRelay
import RxSwift

final class HomeViewModel {
    private let disposeBag: DisposeBag
    private let memberUseCase: MemberUseCase
    let profileImage: PublishRelay<Data>

    init() {
        disposeBag = DisposeBag()
        memberUseCase = MemberUseCase()
        profileImage = PublishRelay()
    }

    func requestMemberMe() {
        memberUseCase.getProfileData()
            .subscribe(onNext: { [weak self] result in
                UserDefaultsRepository.saveProfileImagePath(value: result.profileImage)
                self?.loadProfileImage()
            })
            .disposed(by: disposeBag)
    }

    func loadProfileImage() {
        memberUseCase.loadProfileImage()
            .subscribe(onNext: { [weak self] image in
                self?.profileImage.accept(image)
            })
            .disposed(by: disposeBag)
    }
}
