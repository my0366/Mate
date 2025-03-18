//
//  TicketCreateRequestDTO.swift
//  Mate
//
//  Created by Jae Kyeong Ko on 2022/12/16.
//

import Foundation

struct TicketCreateRequestDTO: Codable {
    let memberId: Int
    let startArea: String
    let endArea: String
    let boardingPlace: String
    let startDayMonth: String
    let dayStatus: String
    let startTime: String
    let openChatUrl: String
    let recruitPerson: Int
    let ticketType: String
    let ticketPrice: Int
}
