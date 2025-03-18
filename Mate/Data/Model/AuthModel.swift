//
//  AuthModel.swift
//  Mate
//
//  Created by 성제 on 2022/12/08.
//

import Foundation

// MARK: - code에 TokenData가 나올것으로 예상하고 작성
struct ResponseToken: Codable, Hashable {
    var grantType: String
    var accessToken: String
    var refreshToken: String
    var accessTokenExpiresIn: Int
    var refreshTokenExpiresIn: Int
}
