//
//  DayChoiceViewModel.swift
//  Mate
//
//  Created by Jae Kyeong Ko on 2022/11/30.
//
import UIKit

import RxRelay
import RxSwift

final class DayChoiceViewModel {
    private let authUseCase: AuthUseCase
    private let disposeBag: DisposeBag
    let message: PublishRelay<String>

    var memberTimeTable: [TimeTable]
    var name: String?
    var studentNumber: String?
    var department: String?
    var phoneNumber: String?
    var auth: String?
    var profileImage: UIImage?

    init() {
        authUseCase = AuthUseCase()
        disposeBag = DisposeBag()
        message = PublishRelay()
        memberTimeTable = []
    }

    func signUp() {
        guard let studentNumber = studentNumber,
              let name = name,
              let department = department,
              let phoneNumber = phoneNumber,
              let auth = auth else {
            return
        }

        let memberRequestDTO = MemberRequestDTO(studentNumber: studentNumber,
                                                memberName: name,
                                                department: department,
                                                phoneNumber: phoneNumber,
                                                auth: auth,
                                                area: "",
                                                memberTimeTable: memberTimeTable)

        authUseCase.requestSignUp(memberRequestDTO: memberRequestDTO,
                                  profileImage: profileImage).subscribe { responseMessage in
            if let result = responseMessage.element {
                self.message.accept(result.message)
            }
        }.disposed(by: disposeBag)
    }
}
