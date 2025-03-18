//
//  UIViewController+Extentsions.swift
//  Mate
//
//  Created by 성제 on 2022/12/07.
//

import UIKit
import SwiftUI

extension UIViewController {

    private struct VCRepresentable: UIViewControllerRepresentable {
        let viewController: UIViewController

        func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
        }

        func makeUIViewController(context: Context) -> some UIViewController {
            return viewController
        }
    }

    func getRepresentable() -> some View {
        VCRepresentable(viewController: self)
    }
}
