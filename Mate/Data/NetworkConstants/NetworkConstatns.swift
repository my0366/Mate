//
//  NetworkConstatns.swift
//  Mate
//
//  Created by 성제 on 2022/12/08.
//

import Foundation

// BaseResponseModel
struct BaseResponse: Codable {
    var status: Int
    var message: String
}

final class NetworkConstants {
    // 카풀 BaseURL
    static var carpoolBaseURL: URL {
        return URL(string: "http://13.209.43.209:8080/ticket")!
    }

    // 인증 관련 BaseURL
    static var authBaseURL: URL {
        return URL(string: "http://13.209.43.209:8080/auth")!
    }

    // 회원 관련 BaseURL
    static var memberBaseeURL: URL {
        return URL(string: "http://13.209.43.209:8080/member")!
    }
}
