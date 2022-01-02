//
//  Colors.swift
//  VEMTestProject
//
//  Created by kjs on 2022/01/02.
//

import CoreGraphics

enum Colors: CaseIterable {
    case red, orange, yellow, green, blue, indigo, white, black

    func cgColor(alpha: CGFloat) -> CGColor {
        switch self {
        case .red:
            return CGColor(red: 242/255, green: 8/255, blue: 0, alpha: alpha)
        case .orange:
            return CGColor(red: 253/255, green: 139/255, blue: 0, alpha: alpha)
        case .yellow:
            return CGColor(red: 231/255, green: 226/255, blue: 0, alpha: alpha)
        case .green:
            return CGColor(red: 48/255, green: 216/255, blue: 0, alpha: alpha)
        case .blue:
            return CGColor(red: 60/255, green: 112/255, blue: 239/255, alpha: alpha)
        case .indigo:
            return CGColor(red: 94/255, green: 2/255, blue: 233/255, alpha: alpha)
        case .white:
            return CGColor(red: 1, green: 1, blue: 1, alpha: alpha)
        case .black:
            return CGColor(red: 0, green: 0, blue: 0, alpha: alpha)
        }
    }
}
