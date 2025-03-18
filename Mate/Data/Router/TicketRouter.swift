//
//  CarpoolRouter.swift
//  Mate
//
//  Created by 성제 on 2022/12/08.
//

import Foundation
import Alamofire

// MARK: Carpool Router : 카풀 통신에 필요한 기본 구성만 작성
enum TicketRouter: URLRequestConvertible {

    // MARK: - Cases
    case createTicket(ticketCreateRequestDTO: TicketCreateRequestDTO)
    case getTicketList
    case readTicket(id: Int)
    case readMyTicket
    case updateTicket(id: Int, status: String)

    // MARK: - Methodsc
    var method: HTTPMethod {
        switch self {
        case .createTicket:
            return .post
        default:
            return .get
        }
    }

    var headers: HTTPHeaders {
        switch self {
        default:
            return [
                "Content-Type": "application/json",
                "Authorization": "\("Bearer") \(UserDefaultsRepository.accessToken)"
            ]
        }
    }

    // MARK: - Paths
    var path: String {
        switch self {
        case .createTicket:
            return "/new"
        case .getTicketList:
            return "/list"
        case .readTicket(let id):
            return "/read/\(id)"
        case .readMyTicket:
            return "/promises"
        case .updateTicket(let id, _):
            return "/update/\(id)"
        }
    }

    // MARK: - Parameters
    var parameters: Parameters? {
        switch self {
        case .createTicket(let ticketCreateRequestDTO):
            return ["memberId": ticketCreateRequestDTO.memberId,
                    "startArea": ticketCreateRequestDTO.startArea,
                    "endArea": ticketCreateRequestDTO.endArea,
                    "boardingPlace": ticketCreateRequestDTO.boardingPlace,
                    "startDayMonth": ticketCreateRequestDTO.startDayMonth,
                    "dayStatus": ticketCreateRequestDTO.dayStatus,
                    "startTime": ticketCreateRequestDTO.startTime,
                    "openChatUrl": ticketCreateRequestDTO.openChatUrl,
                    "recruitPerson": ticketCreateRequestDTO.recruitPerson,
                    "ticketType": ticketCreateRequestDTO.ticketType,
                    "ticketPrice": ticketCreateRequestDTO.ticketPrice]
        case .updateTicket(_, let status):
            return ["status": status]
        default:
            return nil
        }
    }

    // MARK: - Encoding
    var encoding: ParameterEncoding {
        switch self {
        default:
            return JSONEncoding.default
        }
    }

    // MARK: - URL Request
    func asURLRequest() throws -> URLRequest {
        let url = NetworkConstants.carpoolBaseURL.appendingPathComponent(path)
        var urlRequest = URLRequest(url: url)

        // HTTP Method
        urlRequest.method = method
        urlRequest.headers = headers

        // Parameters - 파라미터 Encoding
        if let parameters = parameters {
            return try encoding.encode(urlRequest, with: parameters)
        }

        return urlRequest
    }
}
