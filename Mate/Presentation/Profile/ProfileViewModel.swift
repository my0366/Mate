//
//  ProfileViewModel.swift
//  Mate
//
//  Created by 성제 on 2022/12/07.
//

import Foundation
import RxSwift
import RxCocoa

class ProfileViewModel {

    static let shared = ProfileViewModel()
    let disposeBag = DisposeBag()

    private let memberUseCase: MemberUseCase
    var memberTimeTable: [TimeTable]
    var profileDataSubject: BehaviorRelay<MemberMe>
    var isLoading: Bool = false

    init() {
        memberTimeTable = []
        memberUseCase = MemberUseCase()
        profileDataSubject = BehaviorRelay(value: MemberMe(memberRole: "",
                                                           studentNumber: "",
                                                           memberName: "",
                                                           department: "",
                                                           phoneNumber: "",
                                                           profileImage: "",
                                                           memberTimeTable: []))
    }

    func getProfileData() {
        DispatchQueue.main.async {
            self.isLoading = true
            print(self.isLoading)
        }

        memberUseCase.getProfileData().subscribe(onNext: { [weak self] result in
            guard let self = self else {
                return
            }
            self.isLoading = false
            self.profileDataSubject.accept(result)
        }, onError: { err in
            print(err)
        })
        .disposed(by: disposeBag)
    }
}
