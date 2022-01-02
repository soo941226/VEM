//
//  VEM.swift
//  VEMTestProject
//
//  Created by kjs on 2021/12/20.
//

import UIKit
import CoreGraphics
import QuartzCore

//MARK: - public interface for particle effects
public enum Particle {
    case withSnow
    case withBubble
    case withBallon

    func ready(for view: UIView) -> Runable {
        switch self {
        case .withSnow:
            return SnowEffect(for: view)
        case .withBubble:
            return BubbleEffect(for: view)
        case .withBallon:
            return BalloonEffect(for: view)
        }
    }
}


//MARK: - Definition about ParticleEffectable
private protocol ParticleEffectable {
    var cells: [CAEmitterCell] { get }
    var emitterLayer: CAEmitterLayer { get }
}


//MARK: - basic concepts of ParticleEffect
private class ParticleEffect: Effect, ParticleEffectable {
    fileprivate unowned var background: CALayer!
    fileprivate var cells = [CAEmitterCell]()
    fileprivate var emitterLayer = CAEmitterLayer()

    required fileprivate init(for view: UIView) {
        self.background = view.layer
    }

    fileprivate func setUpCells(with block: () -> [CAEmitterCell]) {
        cells = block()
    }

    fileprivate func setUpLayer(with block: (CAEmitterLayer) -> Void) {
        emitterLayer.emitterCells = cells
        block(emitterLayer)
    }

    func run() -> Stopable {
        background.addSublayer(emitterLayer)

        return self
    }

    func stop() {
        emitterLayer.lifetime = 0
    }
}


//MARK: - Snow Effect
final private class SnowEffect: ParticleEffect {
    override func run() -> Stopable {
        setUpCells {
            let snow = CAEmitterCell()
            snow.contents = UIImage(systemName: "snowflake")?.filled(with: .white)?.cgImage

            snow.lifetime = 20.0
            snow.birthRate = 20.0

            snow.scale = 0.4
            snow.scaleRange = 0.3

            snow.velocity = -50
            snow.velocityRange = 50

            snow.spin = 0
            snow.spinRange = 0.5

            snow.yAcceleration = 10
            snow.xAcceleration = 5
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


//MARK: - Bubble Effect
final private class BubbleEffect: ParticleEffect {
    override func run() -> Stopable {
        setUpCells {
            let image = Painter().drawBubble()

            let bubble = CAEmitterCell()
            bubble.contents = image?.cgImage

            bubble.lifetime = 20.0
            bubble.birthRate = 12.0

            bubble.scale = 0.4
            bubble.scaleRange = 0.3

            bubble.velocity = 50
            bubble.velocityRange = 20

            bubble.spinRange = 0.2

            bubble.yAcceleration = -15
            bubble.xAcceleration = 10
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

//MARK: - Balloon Effect
final private class BalloonEffect: ParticleEffect {
    
}
