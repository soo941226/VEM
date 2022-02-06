//
//  File.swift
//  VEMTestProject
//
//  Created by kjs on 2021/12/27.
//

import UIKit

extension UIImage {
    func filled(with color: UIColor, isOpaque: Bool = false) -> UIImage? {
        let format = imageRendererFormat
        format.opaque = isOpaque
        
        return UIGraphicsImageRenderer(size: size, format: format).image { _ in
            color.set()
            withRenderingMode(.alwaysTemplate).draw(at: .zero)
        }
    }
}
