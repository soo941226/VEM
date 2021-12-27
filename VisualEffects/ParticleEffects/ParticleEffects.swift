//
//  VisualEffects.swift
//  VisualEffectTestProject
//
//  Created by kjs on 2021/12/20.
//

import UIKit
import CoreGraphics
import QuartzCore

private protocol Effectable {
    var cells: [CAEmitterCell] { get }
    var emitterLayer: CAEmitterLayer { get }
}

enum Particle {
    case withSnow
    func ready(for view: UIView) -> RunableEffect {
        switch self {
        case .withSnow:
            return SnowEffect().ready(for: view)
        }
    }
}

class ParticleEffect: Effect, Effectable {
    fileprivate unowned var background: CALayer!
    fileprivate var cells = [CAEmitterCell]()
    fileprivate var emitterLayer = CAEmitterLayer()

    fileprivate init() { }

    fileprivate func setUpCells(with block: () -> [CAEmitterCell]) {
        cells = block()
    }

    fileprivate func setUpLayer(with block: (CAEmitterLayer) -> Void) {
        emitterLayer.emitterCells = cells
        block(emitterLayer)
    }

    func ready(for view: UIView) -> Effect {
        self.background = view.layer
        return self
    }

    func run() {
        background.addSublayer(emitterLayer)
    }
}

final private class SnowEffect: ParticleEffect {
    override func run() {
        setUpCells {
            let cell = CAEmitterCell()
            cell.contents = UIImage(systemName: "snowflake")?.filled(with: .white)?.cgImage

            cell.lifetime = 20.0
            cell.birthRate = 20.0

            cell.scale = 0.4
            cell.scaleRange = 0.3

            cell.velocity = -100
            cell.velocityRange = 50

            cell.spin = 1.0
            cell.spinRange = 3.0

            cell.yAcceleration = 30
            cell.xAcceleration = 10
            cell.emissionRange = .pi

            return [cell]
        }

        setUpLayer { (layer: CAEmitterLayer) in
            layer.emitterPosition = CGPoint(x: background.bounds.width / 2.0, y: -100)
            layer.emitterSize = CGSize(width: background.bounds.width, height: 0)
            layer.emitterShape = CAEmitterLayerEmitterShape.line
            layer.beginTime = CACurrentMediaTime()
        }

        super.run()
    }
}

