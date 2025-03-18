//
//  UIImage+Extensions.swift
//  Mate
//
//  Created by Jae Kyeong Ko on 2022/11/17.
//

import UIKit

extension UIImage {
    convenience init?(imageSet: ImageSet) {
        self.init(named: imageSet.rawValue)
    }

    func resizedImage(size: CGSize) -> UIImage {
        return UIGraphicsImageRenderer(size: size).image { _ in
            self.draw(in: CGRect(origin: .zero, size: size))
        }
    }
}
