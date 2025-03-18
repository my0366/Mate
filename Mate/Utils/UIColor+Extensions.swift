//
//  UIColor+Extensions.swift
//  Mate
//
//  Created by Jae Kyeong Ko on 2022/11/17.
//

import UIKit

extension UIColor {
    convenience init?(colorSet: ColorSet) {
        self.init(named: colorSet.rawValue)
    }
}
