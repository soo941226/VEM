//
//  BubbleEffect.swift
//  VEMTestProject
//
//  Created by kjs on 2022/01/03.
//

#if os(iOS)
import UIKit

internal final class BubbleEffect: ParticleEffect {
    override func run() -> Stopable {
        setUpCells {
            let image = Painter().drawBubble()

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
}
#endif
