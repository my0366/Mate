//
//  AuthRouter.swift
//  Mate
//
//  Created by 성제 on 2022/12/08.
//

import Foundation
import Alamofire
import UIKit

// MARK: Auth Router : 로그인,회원가입,로그아웃,토큰 재발급 통신에 필요한 기본 설정
enum AuthRouter: URLRequestConvertible {

    // MARK: - Cases
    case signup(memberRequestDTO: MemberRequestDTO, profileImage: UIImage?)
    case reissue(accessToken: String, refreshToken: String)
    case logout(accessToken: String, refreshToken: String)
    case login(loginRequestDTO: LoginRequestDTO)

    // MARK: - Methodsc
    var method: HTTPMethod {
        switch self {
        default:
            return .post
        }
    }

    var headers: HTTPHeaders {
        switch self {
        case .signup:
            return ["Content-Type": "multipart/form-data"]
        default:
            return ["Content-Type": "application/json"]
        }
    }

    // MARK: - Paths
    var path: String {
        switch self {
        case .signup:
            return "/signup"
        case .reissue:
            return "/reissue"
        case .logout:
            return "/logout"
        case .login:
            return "/login"
        }
    }

    // MARK: - Parameters
    var parameters: Parameters? {
        switch self {
        case .signup:
            return nil
        case .reissue(let accessToken, let refreshToken):
            return ["accessToken": accessToken,
                    "refreshToken": refreshToken]
        case .login(let loginRequestDTO):
            return ["studentNumber": loginRequestDTO.studentNumber,
                    "memberName": loginRequestDTO.memberName,
                    "phoneNumber": loginRequestDTO.phoneNumber]
        case .logout(let accessToken, let refreshToken):
            return ["accessToken": accessToken,
                    "refreshToken": refreshToken]
        }
    }

    // MARK: - Encoding
    var encoding: ParameterEncoding {
        switch self {
        default:
            return JSONEncoding.default
        }
    }

    var multipartFormData: MultipartFormData {
        let multipartFormData = MultipartFormData()
        switch self {
        case .signup(let memberRequestDTO, let profileImage):
            var requestStringData = ""
            do {
                let jsonData: Data = try JSONEncoder().encode(memberRequestDTO)
                let jsonString: String = String.init(data: jsonData, encoding: .utf8) ?? "\(SignUpError.fail)"
                requestStringData = jsonString
            } catch {
                print("Cannot Convert to JSON String")
            }

            print(requestStringData)
            let imageData = profileImage?.jpegData(compressionQuality: 0.3)
            multipartFormData.append("\(requestStringData)".data(using: .utf8) ?? Data(),
                                     withName: "memberRequestDTO",
                                     mimeType: "application/json")
            multipartFormData.append(imageData ?? Data(), withName: "image", fileName: "profile.png")
        default: ()
        }
        return multipartFormData
    }

    // MARK: - URL Request
    func asURLRequest() throws -> URLRequest {
        let url = NetworkConstants.authBaseURL.appendingPathComponent(path)
        var urlRequest = URLRequest(url: url)

        // HTTP Method
        urlRequest.method = method
        // HTTP Headers
        urlRequest.headers = headers

        // Parameters - 파라미터 Encoding
        if method == .post, let parameters = parameters {
            return try encoding.encode(urlRequest, with: parameters)
        }

        return urlRequest
    }
}

extension JSONEncoder {
    func encodeJSONObject<T: Encodable>(_ value: T, options opt: JSONSerialization.ReadingOptions = []) throws -> Any {
        let data = try encode(value)
        return try JSONSerialization.jsonObject(with: data, options: opt)
    }
}
