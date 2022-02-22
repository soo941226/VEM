//
//  MatrixEffect.swift
//  VEMTestProject
//
//  Created by kjs on 2022/02/15.
//

#if os(iOS)
import UIKit

final class MatrixEffect: ParticleEffect {
    required init(for view: UIView) {
        super.init(for: view)
        marginToDeleteAfterStop = 5.0
    }

    func ready(with strings: [String]) {
        setUpCells {
            let images = strings.map { string in
                return cgImage(from: styledLabel(with: string))
            }

            var texts = [CAEmitterCell]()

            for image in images {
                let text = CAEmitterCell()
                text.contents = image
                text.lifetime = 10.0
                text.birthRate = 4.0

                text.scale = 1.0
                text.scaleRange = 0.6

                text.velocity = -200.0
                text.velocityRange = -150.0
                texts.append(text)
            }

            return texts
        }

        setUpLayer { layer in
            layer.emitterPosition = CGPoint(x: background.bounds.width / 2.0, y: -100)
            layer.emitterSize = CGSize(width: background.bounds.width, height: 0)
            layer.emitterShape = .line
            layer.beginTime = CACurrentMediaTime()
        }
    }

    private func styledLabel(with string: String) -> UILabel {
        let breadthBasis = 30.0
        let label = UILabel(frame: .init(
            x: .zero,
            y: .zero,
            width: breadthBasis,
            height: CGFloat(string.count) * breadthBasis
        ))

        label.alpha = 0.85
        label.textColor = .green
        label.numberOfLines = .zero
        label.adjustsFontSizeToFitWidth = true
        label.font = .preferredFont(forTextStyle: .body)
        label.text = string.map{ $0.description }.joined(separator: "\n")

        return label
    }

    private func cgImage(from label: UILabel) -> CGImage? {
        UIGraphicsBeginImageContext(label.frame.size)
        var cgImage: CGImage?
        if let context = UIGraphicsGetCurrentContext() {
            label.layer.render(in: context)
            cgImage = context.makeImage()
            UIGraphicsEndImageContext()
        }
        return cgImage
    }
}
#endif
