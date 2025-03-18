//
//  Ticket.swift
//  Mate
//
//  Created by 성제 on 2022/12/13.
//

import Foundation

struct TicketList: Codable {
    var id: Int
    var profileImage: String?
    var dayStatus: String
    var startArea: String
    var startTime: String
    var recruitPerson: Int
    var currentPersonCount: Int
}

struct TicketDetail: Codable {
    var id: Int
    var memberName: String
    var profileImage: String
    var dayStatus: String
    var startArea: String
    var startDayMonth: String
    var startTime: String
    var endArea: String
    var recruitPerson: Int
    var boardingPlace: String
    var ticketType: String
//    var ticketPrice: Int?
//    var paassengers : []
}
