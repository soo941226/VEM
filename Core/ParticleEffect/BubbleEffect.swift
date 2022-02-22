//
//  BubbleEffect.swift
//  VEMTestProject
//
//  Created by kjs on 2022/01/03.
//

#if os(iOS)
import UIKit

internal final class BubbleEffect: ParticleEffect {
    required init(for view: UIView) {
        super.init(for: view)
        marginToDeleteAfterStop = 10.0
    }

    override func run() -> Stopable {
        setUpCells {
            let image = drawBubble()

            let bubble = CAEmitterCell()
            bubble.contents = image

            bubble.lifetime = 20.0
            bubble.birthRate = 12.0

            bubble.scale = 0.4
            bubble.scaleRange = 0.3

            bubble.velocity = 50.0
            bubble.velocityRange = 20.0

            bubble.spinRange = 0.2

            bubble.yAcceleration = -15.0
            bubble.xAcceleration = 10.0
            bubble.emissionRange = .pi

            return [bubble]
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

    private func drawBubble() -> CGImage? {
        let defaultStrokeColor = CGColor(red: 0.75, green: 0.75, blue: 0.75, alpha: 0.65)
        let defaultInnerColor = CGColor(red: 0.75, green: 0.75, blue: 0.75, alpha: 0.15)

        let radius: CGFloat = 40.0
        let center = CGPoint(x: radius, y: radius)
        let bubbleSize = CGSize(width: radius * 2, height: radius * 2)

        var painter = Painter(with: bubbleSize)

        painter.setStrokeColor(with: defaultStrokeColor)

        painter.strokeArc(
            center: center, radius: radius * 0.75,
            startAngle: .quarterArc, endAngle: .pi, clockwise: false
        )

        painter.strokeArc(
            center: center, radius: radius * 0.7,
            startAngle: .quarterArc, endAngle: .pi, clockwise: false
        )

        painter.setLineWidth(with: 2.0)
        painter.strokeArc(
            center: center, radius: radius,
            startAngle: 0, endAngle: .circumference, clockwise: true
        )

        painter.fillArc(
            center: center, radius: radius,
            startAngle: 0, endAngle: .circumference, clockwise: true,
            color: defaultInnerColor
        )

        return painter.cgImage()
    }

}
#endif
