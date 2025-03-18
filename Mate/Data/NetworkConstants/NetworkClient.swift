//
//  NetworkClient.swift
//  Mate
//
//  Created by 성제 on 2022/12/08.
//

import Foundation
import Alamofire

class NetworkClient {

    static let session: Session = {
        let configuration = URLSessionConfiguration.af.default
        let apiLogger = APIMonitor()
        return Session(configuration: configuration, eventMonitors: [apiLogger])
    }()

    typealias OnSuccess<T> = ((T) -> Void)
    typealias OnFailure = ((_ error: Error) -> Void)

    // MARK: - Base Client
    // Object : Model, router : Router에 요청할 함수, (success, failure) -> 클로저로 성공,실패시 Network요청시 받아온 데이터 탈출
    static func request<T>(_ object: T.Type,
                           router: URLRequestConvertible,
                           success: @escaping OnSuccess<T>,
                           failure: @escaping OnFailure) where T: Decodable {
        session.request(router)
            .validate(statusCode: 200..<500)
            .responseDecodable(of: object) { response in
                switch response.result {
                case .success:
                    guard let decodedData = response.value else { return }
                    success(decodedData)
                case .failure(let err):
                    failure(err)
                }
            }
    }

    // MARK: - Overloading BaseClinet : MultiPartFormData Client
    // Object : Model, router : Router에 요청할 함수
    // multiPartFormData : Router의 multiPartFormData 입력
    // (success, failure) -> 클로저로 성공,실패시 Network요청시 받아온 데이터 탈출
    static func request<T>(_ object: T.Type,
                           router: URLRequestConvertible,
                           multiPartFormData: MultipartFormData,
                           success: @escaping OnSuccess<T>,
                           failure: @escaping OnFailure) where T: Decodable {
        session.upload(multipartFormData: multiPartFormData, with: router).validate(statusCode: 200..<500)
            .responseDecodable(of: object) { response in
                switch response.result {
                case .success:
                    guard let decodedData = response.value else { return }
                    success(decodedData)
                case .failure(let err):
                    failure(err)
                }
            }
    }

    static func request(router: URLRequestConvertible,
                        success: @escaping (Data) -> Void,
                        failure: @escaping OnFailure) {
        session.request(router)
            .validate(statusCode: 200..<500)
            .response { response in
                switch response.result {
                case .success(let data):
                    if let data = data {
                        success(data)
                    }
                case .failure(let error):
                    failure(error)
                }
            }
    }
}
