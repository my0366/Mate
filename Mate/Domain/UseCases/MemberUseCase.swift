//
//  TicketUseCase.swift
//  Mate
//
//  Created by 성제 on 2022/12/13.
//

import Foundation
import RxSwift
import Alamofire

class MemberUseCase {
    func getProfileData() -> Observable<MemberMe> {
        return Observable.create { observer in
            MemberRepository.getProfileData { profileData in
                observer.onNext(profileData)
            } failure: { error in
                observer.onError(error)
            }
            return Disposables.create()
        }
    }

    func loadProfileImage() -> Observable<Data> {
        return Observable.create { observer in
            MemberRepository.loadProfileImage { profileImage in
                observer.onNext(profileImage)
            } failure: { error in
                observer.onError(error)
            }
            return Disposables.create()
        }
    }
}
