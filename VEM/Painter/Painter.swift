//
//  Painter.swift
//  VEMTestProject
//
//  Created by kjs on 2022/01/02.
//

import UIKit

class Painter {
    func drawBubble() -> UIImage? {
        let defaultStrokeColor = CGColor(red: 0.75, green: 0.75, blue: 0.75, alpha: 0.65)
        let defaultInnerColor = CGColor(red: 0.75, green: 0.75, blue: 0.75, alpha: 0.15)

        let radius: CGFloat = 40.0
        let center = CGPoint(x: radius, y: radius)
        let bubbleSize = CGSize(width: radius * 2, height: radius * 2)
        let pen = createContext(by: bubbleSize)

        pen?.setStrokeColor(defaultStrokeColor)

        pen?.strokeArc(
            center: center, radius: radius * 0.75,
            startAngle: .quarterArc, endAngle: .pi, clockwise: false
        )

        pen?.strokeArc(
            center: center, radius: radius * 0.7,
            startAngle: .quarterArc, endAngle: .pi, clockwise: false
        )

        pen?.setLineWidth(2.0)
        pen?.strokeArc(
            center: center, radius: radius,
            startAngle: 0, endAngle: .circumference, clockwise: true
        )

        pen?.fillArc(
            center: center, radius: radius,
            startAngle: 0, endAngle: .circumference, clockwise: true,
            color: defaultInnerColor
        )

       return createImage(from: pen)
    }

    func drawBallon(with color: Colors) -> UIImage? {
        let ballonRadius: CGFloat = 25.0
        let ballonSize = CGSize(width: 50, height: 100)
        let ballonCenter = CGPoint(x: ballonRadius, y: ballonRadius)


        let pen = createContext(by: ballonSize)
        let fillAlpha: CGFloat = 0.5
        let strokeAlpha: CGFloat = 0.35
        let ballonColor = color.cgColor(alpha: fillAlpha)
        let strokeColor = color.cgColor(alpha: strokeAlpha)

        pen?.fillArc(
            center: ballonCenter, radius: ballonRadius,
            startAngle: .zero, endAngle: .circumference, clockwise: true,
            color: ballonColor
        )

        pen?.setStrokeColor(Colors.white.cgColor(alpha: strokeAlpha))
        pen?.strokeArc(
            center: ballonCenter, radius: ballonRadius * 0.75,
            startAngle: .quarterArc, endAngle: .pi, clockwise: false
        )

        pen?.strokeArc(
            center: ballonCenter, radius: ballonRadius * 0.7,
            startAngle: .quarterArc, endAngle: .pi, clockwise: false
        )

        let stringRadius = ballonRadius / 3
        let dividedHeight = ballonSize.height / 2
        let startPointOfString = CGPoint(x: ballonRadius, y: ballonRadius + stringRadius * 2)
        let controlPointOfString = CGPoint(x: ballonRadius, y: dividedHeight + ballonRadius)
        let endPointOfString = CGPoint(x: .zero , y: ballonSize.height)

        pen?.setStrokeColor(strokeColor)
        pen?.move(to: startPointOfString)
        pen?.addQuadCurve(
            to: endPointOfString,
            control: controlPointOfString
        )
        pen?.strokePath()

        return createImage(from: pen)
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

    func createImage(from context: CGContext?) -> UIImage? {
        context?.closePath()
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image
    }
}


//MARK: - private extension of CGContext
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


//MARK: - private extension of CGFloat for circumference & quarterArc
private extension CGFloat {
    static var circumference: CGFloat {
        return .pi * 2
    }

    static var quarterArc: CGFloat {
        return .pi / 2
    }
}
