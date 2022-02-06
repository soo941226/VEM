//
//  SnowEffect.swift
//  VEMTestProject
//
//  Created by kjs on 2022/01/03.
//

import UIKit

internal final class SnowEffect: ParticleEffect {
    override func run() -> Stopable {
        setUpCells {
            let snow = CAEmitterCell()
            snow.contents = UIImage(systemName: "snowflake")?.filled(with: .white)?.cgImage

            snow.lifetime = 20.0
            snow.birthRate = 20.0

            snow.scale = 0.4
            snow.scaleRange = 0.3

            snow.velocity = -50.0
            snow.velocityRange = 50.0

            snow.spin = 0
            snow.spinRange = 0.5

            snow.yAcceleration = 10.0
            snow.xAcceleration = 5.0
            snow.emissionRange = .pi

            return [snow]
        }

        setUpLayer { layer in
            layer.emitterPosition = CGPoint(x: background.bounds.width / 2.0, y: -100)
            layer.emitterSize = CGSize(width: background.bounds.width, height: 0)
            layer.emitterShape = .line
            layer.beginTime = CACurrentMediaTime()
        }

        return super.run()
    }
}
