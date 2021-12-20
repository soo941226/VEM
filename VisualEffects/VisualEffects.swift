//
//  VisualEffects.swift
//  VisualEffectTestProject
//
//  Created by kjs on 2021/12/20.
//

import UIKit
import CoreGraphics
import QuartzCore

protocol Effect {
    func ready(for layer: CALayer) -> Effect
    func run()
}

class SnowEffect: Effect {
    private unowned var layer: CALayer!
    private var cell: CAEmitterCell {
        let cell = CAEmitterCell()
        let image = UIImage(systemName: "snowflake")
        cell.contents = image?.filled(with: .white)?.cgImage
        cell.lifetime = 20.0
        cell.birthRate = 15

        cell.scale = 0.4
        cell.scaleRange = 0.3
        cell.velocity = -50
        cell.velocityRange = -30
        cell.spin = 1.0
        cell.spinRange = 1.0
        cell.yAcceleration = 30
        cell.xAcceleration = 10
        cell.emissionRange = .pi
        return cell
    }

    init() { }


    func ready(for layer: CALayer) -> Effect {
        self.layer = layer
        return self
    }

    let emitterLayer = CAEmitterLayer()

    func run() {
        emitterLayer.emitterPosition = CGPoint(x: layer.bounds.width / 2.0, y: -50)
        emitterLayer.emitterSize = CGSize(width: layer.bounds.width, height: 0)
        emitterLayer.emitterShape = CAEmitterLayerEmitterShape.line
        emitterLayer.beginTime = CACurrentMediaTime()
        emitterLayer.timeOffset = 10
        emitterLayer.emitterCells = [cell]
        layer.addSublayer(emitterLayer)
    }
}

enum VisualEffects {
    case snow

    var manager: Effect {
        switch self {
        case .snow:
            return SnowEffect()
        }
    }
}

extension UIImage {
    func filled(with color: UIColor, isOpaque: Bool = false) -> UIImage? {
        let format = imageRendererFormat
        format.opaque = isOpaque
        return UIGraphicsImageRenderer(size: size, format: format).image { _ in
            color.set()
            withRenderingMode(.alwaysTemplate).draw(at: .zero)
        }
    }
}
