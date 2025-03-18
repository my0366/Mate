//
//  TicketRepository.swift
//  Mate
//
//  Created by 성제 on 2022/12/13.
//

import Foundation

class TicketRepository {

    static func createTicket(ticketCreateRequestDTO: TicketCreateRequestDTO,
                             success: @escaping (BaseResponse) -> Void,
                             failure: @escaping (Error) -> Void) {
        NetworkClient.request(
            BaseResponse.self,
            router: TicketRouter.createTicket(ticketCreateRequestDTO: ticketCreateRequestDTO),
            success: { response in
                success(response)
            }, failure: { error in
                failure(error)
            })
    }

    static func getTicketList(success: @escaping ([TicketList]) -> Void,
                              failure: @escaping (Error) -> Void) {
        NetworkClient.request([TicketList].self, router: TicketRouter.getTicketList) { value in
            success(value)
        } failure: { error in
            failure(error)
        }

    }

    static func getReadTicket(id: Int,
                              success: @escaping (TicketDetail) -> Void,
                              failure: @escaping (Error) -> Void) {
        NetworkClient.request(TicketDetail.self, router: TicketRouter.readTicket(id: id)) { value in
            success(value)
        } failure: { error in
            failure(error)
        }
    }

    static func getMyTicketData(success: @escaping ([TicketDetail]) -> Void,
                                failure: @escaping (Error) -> Void) {
        NetworkClient.request([TicketDetail].self, router: TicketRouter.readMyTicket) { value in
            success(value)
        } failure: { error in
            failure(error)
        }
    }

    static func updateTicket(id: Int,
                             status: String,
                             success: @escaping (BaseResponse) -> Void,
                             failure: @escaping (Error) -> Void) {
        NetworkClient.request(BaseResponse.self, router: TicketRouter.updateTicket(id: id, status: status)) { value in
            success(value)
        } failure: { error in
            failure(error)
        }
    }
}
