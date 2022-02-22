//
//  BalloonEffect.swift
//  VEMTestProject
//
//  Created by kjs on 2022/01/03.
//

#if os(iOS)
import UIKit

internal final class BalloonEffect: ParticleEffect {
    required init(for view: UIView) {
        super.init(for: view)
        marginToDeleteAfterStop = 8.0
    }

    override func run() -> Stopable {
        setUpCells {
            var ballons = [CAEmitterCell]()
            let colors = Colors.allCases

            for color in colors {
                let image = drawBallon(with: color)
                let ballon = CAEmitterCell()
                ballon.contents = image

                ballon.lifetime = 15.0
                ballon.birthRate = 1.0

                ballon.scale = 0.8
                ballon.scaleRange = 0.2

                ballon.velocity = 100.0
                ballon.emissionRange = .quarterArc

                ballons.append(ballon)
            }

            return ballons
        }

        setUpLayer { layer in
            layer.emitterPosition = CGPoint(
                x: background.bounds.width / 2.0,
                y: background.bounds.height + 50
            )
            layer.emitterSize = CGSize(width: background.bounds.width, height: .zero)
            layer.emitterShape = .line
            layer.beginTime = CACurrentMediaTime()
        }

        return super.run()
    }
    
    private func drawBallon(with color: Colors) -> CGImage? {
        let ballonRadius: CGFloat = 25.0
        let ballonSize = CGSize(width: 50, height: 100)
        let ballonCenter = CGPoint(x: ballonRadius, y: ballonRadius)

        let fillAlpha: CGFloat = 0.5
        let strokeAlpha: CGFloat = 0.35
        let ballonColor = color.cgColor(alpha: fillAlpha)
        let strokeColor = color.cgColor(alpha: strokeAlpha)

        var painter = Painter(with: ballonSize)

        painter.fillArc(
            center: ballonCenter, radius: ballonRadius,
            startAngle: .zero, endAngle: .circumference, clockwise: true,
            color: ballonColor
        )

        painter.setStrokeColor(with: Colors.white.cgColor(alpha: strokeAlpha))
        painter.strokeArc(
            center: ballonCenter, radius: ballonRadius * 0.75,
            startAngle: .quarterArc, endAngle: .pi, clockwise: false
        )

        painter.strokeArc(
            center: ballonCenter, radius: ballonRadius * 0.7,
            startAngle: .quarterArc, endAngle: .pi, clockwise: false
        )

        let stringRadius = ballonRadius / 3
        let dividedHeight = ballonSize.height / 2
        let startPointOfString = CGPoint(x: ballonRadius, y: ballonRadius + stringRadius * 2)
        let controlPointOfString = CGPoint(x: ballonRadius, y: dividedHeight + ballonRadius)
        let endPointOfString = CGPoint(x: .zero , y: ballonSize.height)

        painter.setStrokeColor(with: strokeColor)
        painter.move(to: startPointOfString)
        painter.strokeBezier(to: endPointOfString, curveAt: controlPointOfString)

        return painter.cgImage()
    }

}
#endif
