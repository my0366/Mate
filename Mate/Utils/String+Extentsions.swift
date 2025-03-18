//
//  String+Extentsions.swift
//  Mate
//
//  Created by 성제 on 2022/12/07.
//

extension String {
    func stringToMonth() -> String {

        // Index 값 획득
        let startIndex = index(self.startIndex, offsetBy: 0)
        let endIndex = index(self.startIndex, offsetBy: 2)

        // 파싱
        return String(self[startIndex ..< endIndex])
    }

    func stringToDay() -> String {

        // Index 값 획득
        let startIndex = index(self.startIndex, offsetBy: 2)
        let endIndex = index(self.startIndex, offsetBy: 4)

        // 파싱
        return String(self[startIndex ..< endIndex])
    }
}
