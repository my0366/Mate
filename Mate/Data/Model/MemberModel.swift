//
//  Member.swift
//  Mate
//
//  Created by 성제 on 2022/12/13.
//

import Foundation

struct MemberMe: Codable {
    var memberRole : String
    var studentNumber: String
    var memberName: String
    var department: String
    var phoneNumber: String
    var profileImage: String
    var memberTimeTable: [TimeTable]
}
