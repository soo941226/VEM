//
//  BalloonEffect.swift
//  VEMTestProject
//
//  Created by kjs on 2022/01/03.
//

#if os(iOS)
import UIKit

internal final class BalloonEffect: ParticleEffect {
    override func run() -> Stopable {
        setUpCells {
            var ballons = [CAEmitterCell]()

            let painter = Painter()
            let colors = Colors.allCases

            for color in colors {
                let image = painter.drawBallon(with: color)
                let ballon = CAEmitterCell()
                ballon.contents = image

                ballon.lifetime = 10.0
                ballon.birthRate = 0.4

                ballon.scale = 0.8
                ballon.scaleRange = 0.2

                ballon.velocity = 20.0
                ballon.velocityRange = 5.0

                ballon.xAcceleration = 1.0
                ballon.yAcceleration = -15.0
                ballon.emissionRange = .pi

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
}
#endif
