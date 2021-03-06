//
//  ParticleEffect.swift
//  VEMTestProject
//
//  Created by kjs on 2021/12/20.
//

#if os(iOS)
import UIKit

//MARK: - basic concepts of ParticleEffect
internal class ParticleEffect: Effectable {
    unowned var background: CALayer!
    var marginToDeleteAfterStop = TimeInterval.zero
    var cells = [CAEmitterCell]()
    var emitterLayer: CAEmitterLayer = {
        let layer = CAEmitterLayer()
        layer.shouldRasterize = true
        layer.drawsAsynchronously = true
        return layer
    }()

    required init(for view: UIView) {
        self.background = view.layer
    }

    func run() -> Stopable {
        background.addSublayer(emitterLayer)

        return self
    }

    func stop() {
        emitterLayer.lifetime = 0
    }
}

// MARK: - set up effect
internal extension ParticleEffect {
    func setUpCells(with block: () -> [CAEmitterCell]) {
        cells = block()
    }

    func setUpLayer(with block: (CAEmitterLayer) -> Void) {
        emitterLayer.emitterCells = cells
        block(emitterLayer)
    }
}
#endif
