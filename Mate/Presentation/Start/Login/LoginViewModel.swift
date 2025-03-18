//
//  LoginViewModel.swift
//  Mate
//
//  Created by Jae Kyeong Ko on 2022/12/13.
//

import Foundation

import RxRelay
import RxSwift

final class LoginViewModel {
    private let authUseCase: AuthUseCase

    init() {
        authUseCase = AuthUseCase()
    }

    func requestLogin(studentNumber: String?,
                      memberName: String?,
                      phoneNumber: String?) -> Observable<ResponseToken> {

        return authUseCase.requestLogin(
            loginRequestDTO: LoginRequestDTO(studentNumber: studentNumber ?? "",
                                             memberName: memberName ?? "",
                                             phoneNumber: phoneNumber ?? "")
        )
    }
}
