//
//  Constants.swift
//  Mate
//
//  Created by Jae Kyeong Ko on 2022/11/17.
//

enum ColorSet: String {
    case background
    case shadeBlack
    case neutral10
    case neutral20
    case neutral30
    case neutral50
    case dark
    case red50
    case red60
    case primary10
    case primary50
    case primary60
    case shadeGray
}

enum ImageSet: String {
    case car
    case carArrow
    case dottedArrow
    case plus
    case gear
    case list
    case folder
    case exitButton
    case arrowBottom
    case arrowRight
    case arrowLeft
    case arrowinfo
    case location
    case barEmpty
    case barFill
    case kakaoTalk
}

enum FontNames: String {
    case notoSansKRBold = "NotoSansKR-Bold"
    case notoSansKRRegular = "notoSansKR-Regular"
    case archivoBlack = "ArchivoBlack-Regular"
}

enum Areas: String {
    case inDong = "인동"
    case okGye = "옥계"
    case daeGu = "대구"
    case etc = "그외"

    static let items = [inDong.rawValue, okGye.rawValue, daeGu.rawValue, etc.rawValue]
}

enum DayStatus: String {
    case morning = "오전"
    case afternoon = "오후"

    static let items = [morning.rawValue, afternoon.rawValue]
}

enum PeopleCount: String {
    case one = "1"
    case two = "2"
    case three = "3"
    case four = "4"

    static let items = [one.rawValue, two.rawValue, three.rawValue, four.rawValue]
}

enum CarpoolCost: String {
    case free = "무료"
    case pay = "유료"

    static let items = [free.rawValue, pay.rawValue]
}

enum UserDefaultsKeys: String {
    case isLoggedIn
    case accessToken
    case grantType
    case studentNumber
    case memberName
    case phoneNumber
    case profileImageURL
}
