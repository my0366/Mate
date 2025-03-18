//
//  MemberRouter.swift
//  Mate
//
//  Created by 성제 on 2022/12/08.
//

import Foundation
import Alamofire

// MARK: Member Router : 기본 구성요소 작성
enum MemberRouter: URLRequestConvertible {

    // MARK: - Cases
    case getMember
    case loadProfileImage

    // MARK: - Methodsc
    var method: HTTPMethod {
        switch self {
        default:
            return .get
        }
    }

    // MARK: - Paths
    var path: String {
        switch self {
        case .getMember:
            return "/me"
        case .loadProfileImage:
            return "/profile\(UserDefaultsRepository.profileImagePath)"
        }
    }

    // MARK: - Parameters
    var parameters: Parameters? {
        switch self {
        default:
            return nil
        }
    }

    // MARK: - Encoding
    var encoding: ParameterEncoding {
        switch self {
        default:
            return URLEncoding.default
        }
    }

    // MARK: - URL Request
    func asURLRequest() throws -> URLRequest {
        let url = NetworkConstants.memberBaseeURL.appendingPathComponent(path)
        var urlRequest = URLRequest(url: url)

        // HTTP Method
        urlRequest.method = method

        urlRequest.setValue("Bearer \(UserDefaultsRepository.accessToken)", forHTTPHeaderField: "Authorization")
        // Parameters - 파라미터 Encoding
        if let parameters = parameters {
            return try encoding.encode(urlRequest, with: parameters)
        }

        return urlRequest
    }
}
