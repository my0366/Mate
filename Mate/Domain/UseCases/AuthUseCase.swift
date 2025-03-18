//
//  SignUpUseCase.swift
//  Mate
//
//  Created by Jae Kyeong Ko on 2022/11/30.
//

import UIKit

import Alamofire
import RxSwift

struct AuthUseCase {
    func requestSignUp(memberRequestDTO: MemberRequestDTO, profileImage: UIImage?) -> Observable<BaseResponse> {
        return Observable.create { observer in

            AuthRepository.requestSignUp(memberRequestDTO: memberRequestDTO, profileImage: profileImage
            ) { responseData in
                observer.onNext(responseData)
            } failure: { error in
                observer.onError(error)
            }
            return Disposables.create()
        }
    }

    func requestLogin(loginRequestDTO: LoginRequestDTO) -> Observable<ResponseToken> {
        return Observable.create { observer in
            AuthRepository.requestLogin(loginRequestDTO: loginRequestDTO) { responseData in
                observer.onNext(responseData)
            } failure: { error in
                observer.onError(error)
            }

            return Disposables.create()
        }
    }
}
