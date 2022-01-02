//
//  Painter.swift
//  VEMTestProject
//
//  Created by kjs on 2022/01/02.
//

import UIKit

struct Painter {
    func drawBubble() -> UIImage? {
        let defaultStrokeColor = CGColor(red: 0.75, green: 0.75, blue: 0.75, alpha: 0.65)
        let defaultInnerColor = CGColor(red: 0.75, green: 0.75, blue: 0.75, alpha: 0.15)

        let radius: CGFloat = 40.0
        let center = CGPoint(x: radius, y: radius)
        let circumference = CGFloat.pi * 2
        let quarterArc = CGFloat.pi / 2
        let bubbleSize = CGSize(width: radius * 2, height: radius * 2)
        let pen = createContext(by: bubbleSize)

        pen?.setStrokeColor(defaultStrokeColor)

        pen?.strokeArc(
            center: center, radius: radius * 0.75,
            startAngle: quarterArc, endAngle: .pi, clockwise: false
        )

        pen?.strokeArc(
            center: center, radius: radius * 0.7,
            startAngle: quarterArc, endAngle: .pi, clockwise: false
        )

        pen?.setLineWidth(2.0)
        pen?.strokeArc(
            center: center, radius: radius,
            startAngle: 0, endAngle: circumference, clockwise: true
        )

        pen?.fillArc(
            center: center, radius: radius,
            startAngle: 0, endAngle: circumference, clockwise: true,
            color: defaultInnerColor
        )

       return createImage(from: pen)
    }

    func drawBallon() -> UIImage? {
        let ballonSize = CGSize(width: 50, height: 100)
        let ballonRadius: CGFloat = 25.0
        let circumference = CGFloat.pi * 2

        let pen = createContext(by: ballonSize)

        pen?.fillArc(
            center: CGPoint(x: ballonRadius, y: ballonRadius), radius: ballonRadius,
            startAngle: .zero, endAngle: circumference, clockwise: true,
            color: CGColor.init(red: drand48(), green: drand48(), blue: drand48(), alpha: drand48())
        )

        return createImage(from: pen)
    }
}

private extension Painter {
    func createContext(by size: CGSize) -> CGContext? {
        UIGraphicsBeginImageContext(size)
        let context = UIGraphicsGetCurrentContext()
        context?.beginPath()
        return context
    }

    func createImage(from context: CGContext?) -> UIImage? {
        context?.closePath()
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image
    }
}

private extension CGContext {
    func strokeArc(
        center: CGPoint,
        radius: CGFloat,
        startAngle: CGFloat,
        endAngle: CGFloat,
        clockwise: Bool
    ) {
        addArc(
            center: center,
            radius: radius,
            startAngle: startAngle,
            endAngle: endAngle,
            clockwise: clockwise
        )
        strokePath()
    }

    func fillArc(
        center: CGPoint,
        radius: CGFloat,
        startAngle: CGFloat,
        endAngle: CGFloat,
        clockwise: Bool,
        color: CGColor
    ) {
        setFillColor(color)
        addArc(
            center: center,
            radius: radius,
            startAngle: startAngle,
            endAngle: endAngle,
            clockwise: clockwise
        )
        fillPath()
    }
}
