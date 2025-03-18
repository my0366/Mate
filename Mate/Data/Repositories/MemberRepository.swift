//
//  CarpoolListRepository.swift
//  Mate
//
//  Created by 성제 on 2022/12/10.
//

import Foundation
import Alamofire

class MemberRepository {

    static func getProfileData(success: @escaping (MemberMe) -> Void,
                               failure: @escaping (Error) -> Void) {
        NetworkClient.request(MemberMe.self, router: MemberRouter.getMember) { response in
            success(response)
        } failure: { error in
            failure(error)
        }
    }

    static func loadProfileImage(success: @escaping (Data) -> Void,
                                 failure: @escaping (Error) -> Void) {
        NetworkClient.request(router: MemberRouter.loadProfileImage) { response in
            success(response)
        } failure: { error in
            failure(error)
        }

    }
}
