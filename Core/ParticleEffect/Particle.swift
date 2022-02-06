//
//  Particle.swift
//  VEMTestProject
//
//  Created by kjs on 2022/01/03.
//

import UIKit.UIView

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
