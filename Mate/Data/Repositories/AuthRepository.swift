//
//  AuthRepository.swift
//  Mate
//
//  Created by 성제 on 2022/12/08.
//

import Foundation
import RxSwift
import UIKit
import Alamofire
class AuthRepository {

    // MARK: API 통신 이후 success, failure -> escaping closure를 이용해 Domain - useCase Layer로 전달
    static func requestSignUp(memberRequestDTO: MemberRequestDTO,
                              profileImage: UIImage?,
                              success: @escaping (BaseResponse) -> Void,
                              failure: @escaping (Error) -> Void) {
        let multiPartFormData = AuthRouter.signup(memberRequestDTO: memberRequestDTO,
                                                  profileImage: profileImage).multipartFormData

        NetworkClient.request(BaseResponse.self,
                              router: AuthRouter.signup(memberRequestDTO: memberRequestDTO, profileImage: profileImage),
                              multiPartFormData: multiPartFormData) { response in
            success(response)
        } failure: { error in
            failure(error)
        }
    }

    static func requestLogin(loginRequestDTO: LoginRequestDTO,
                             success: @escaping (ResponseToken) -> Void,
                             failure: @escaping (Error) -> Void) {
        NetworkClient.request(
            ResponseToken.self,
            router: AuthRouter.login(loginRequestDTO: loginRequestDTO)
        ) { response in
            success(response)
        } failure: { error in
            failure(error)
        }
    }
}
