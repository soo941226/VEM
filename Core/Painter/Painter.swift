//
//  Painter.swift
//  VEMTestProject
//
//  Created by kjs on 2022/01/02.
//

#if os(iOS)
import UIKit

struct Painter {
    private var pen: CGContext?

    init(with boardSize: CGSize) {
        self.pen = createContext(by: boardSize)
    }

    mutating func cgImage() -> CGImage? {
        defer {
            pen = nil
        }
        pen?.closePath()
        let image = pen?.makeImage()
        UIGraphicsEndImageContext()
        return image
    }

    mutating func uiImage() -> UIImage? {
        defer {
            pen = nil
        }
        pen?.closePath()
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image
    }

    func move(to point: CGPoint) {
        pen?.move(to: point)
    }

    func setLineWidth(with width: CGFloat ) {
        pen?.setLineWidth(width)
    }

    func setStrokeColor(with cgColor: CGColor) {
        pen?.setStrokeColor(cgColor)
    }

    func strokeBezier(to end: CGPoint, curveAt point: CGPoint) {
        pen?.addQuadCurve(
            to: end,
            control: point
        )
        pen?.strokePath()
    }

    func strokeArc(
        center: CGPoint, radius: CGFloat,
        startAngle: CGFloat, endAngle: CGFloat, clockwise: Bool
    ) {
        pen?.addArc(
            center: center, radius: radius,
            startAngle: startAngle, endAngle: endAngle, clockwise: clockwise
        )
        pen?.strokePath()
    }

    func fillArc(
        center: CGPoint, radius: CGFloat,
        startAngle: CGFloat, endAngle: CGFloat, clockwise: Bool,
        color: CGColor
    ) {
        pen?.setFillColor(color)
        pen?.addArc(
            center: center, radius: radius,
            startAngle: startAngle, endAngle: endAngle, clockwise: clockwise
        )
        pen?.fillPath()
    }
}

//MARK: - private methods of Painter
private extension Painter {
    func createContext(by size: CGSize) -> CGContext? {
        UIGraphicsBeginImageContext(size)
        let context = UIGraphicsGetCurrentContext()
        context?.beginPath()
        return context
    }
}
#endif
