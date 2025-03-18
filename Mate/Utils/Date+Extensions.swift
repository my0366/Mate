//
//  Date+Extensions.swift
//  Mate
//
//  Created by Jae Kyeong Ko on 2022/12/03.
//

import Foundation

extension Date {
    var tomorrowDate: Date? {
        return Calendar.current.date(byAdding: .day, value: 1, to: self)
    }

    var tomorrowDateString: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM/dd"
        return dateFormatter.string(from: tomorrowDate ?? Date())
    }
}
