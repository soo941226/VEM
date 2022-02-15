//
//  Particle.swift
//  VEMTestProject
//
//  Created by kjs on 2022/01/03.
//

#if os(iOS)
import UIKit

//MARK: - public interface for particle effects
public enum Particle {
    case withSnow
    case withBubble
    case withBallon
    case withMatrix(text: [String])

    public func ready(for view: UIView) -> Runable {
        switch self {
        case .withSnow:
            return SnowEffect(for: view)
        case .withBubble:
            return BubbleEffect(for: view)
        case .withBallon:
            return BalloonEffect(for: view)
        case .withMatrix(let strings):
            let matrixEffect = MatrixEffect(for: view)
            matrixEffect.ready(with: strings)
            return matrixEffect
        }
    }
}
#endif
