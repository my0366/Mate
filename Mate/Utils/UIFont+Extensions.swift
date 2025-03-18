//
//  UIFont+Extensions.swift
//  Mate
//
//  Created by Jae Kyeong Ko on 2022/11/17.
//

import UIKit

extension UIFont {
    static func instance(name: FontNames, size: CGFloat) -> UIFont {
        let font = UIFont(name: name.rawValue, size: size)

        return font ?? systemFont(ofSize: size)
    }
}
