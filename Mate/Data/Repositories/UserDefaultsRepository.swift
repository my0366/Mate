//
//  UserDefaultsRepository.swift
//  Mate
//
//  Created by Jae Kyeong Ko on 2022/12/05.
//

import Foundation

struct UserDefaultsRepository {
    static var isLoggedIn: Bool {
        return UserDefaults.standard.bool(forKey: UserDefaultsKeys.isLoggedIn.rawValue)
    }

    static func saveIsLoggedIn(value: Bool) {
        UserDefaults.standard.set(value, forKey: UserDefaultsKeys.isLoggedIn.rawValue)
    }

    static var accessToken: String {
        return UserDefaults.standard.string(forKey: UserDefaultsKeys.accessToken.rawValue) ?? ""
    }

    static func saveAccessToken(value: String) {
        UserDefaults.standard.set(value, forKey: UserDefaultsKeys.accessToken.rawValue)
    }

    static var grantType: String {
        return UserDefaults.standard.string(forKey: UserDefaultsKeys.grantType.rawValue) ?? ""
    }

    static func saveGrantType(value: String) {
        UserDefaults.standard.set(value, forKey: UserDefaultsKeys.grantType.rawValue)
    }

    static var studentNumber: String {
        return UserDefaults.standard.string(forKey: UserDefaultsKeys.studentNumber.rawValue) ?? ""
    }

    static var name: String {
        return UserDefaults.standard.string(forKey: UserDefaultsKeys.memberName.rawValue) ?? ""
    }

    static var phoneNumber: String {
        return UserDefaults.standard.string(forKey: UserDefaultsKeys.phoneNumber.rawValue) ?? ""
    }

    static func saveUserData(studentNumber: String, name: String, phoneNumber: String) {
        UserDefaults.standard.set(name, forKey: UserDefaultsKeys.memberName.rawValue)
        UserDefaults.standard.set(studentNumber, forKey: UserDefaultsKeys.studentNumber.rawValue)
        UserDefaults.standard.set(phoneNumber, forKey: UserDefaultsKeys.phoneNumber.rawValue)
    }

    static var profileImagePath: String {
        return UserDefaults.standard.string(forKey: UserDefaultsKeys.profileImageURL.rawValue) ?? ""
    }

    static func saveProfileImagePath(value: String) {
        UserDefaults.standard.set(value, forKey: UserDefaultsKeys.profileImageURL.rawValue)
    }
}
