//
//  DTO.swift
//  Mate
//
//  Created by 성제 on 2022/12/08.
//

import Foundation

struct MemberRequestDTO: Codable {
    let studentNumber: String
    let memberName: String
    let department: String
    let phoneNumber: String
    let auth: String
    let area: String
    let memberTimeTable: [TimeTable]
}
