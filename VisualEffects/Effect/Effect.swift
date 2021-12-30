//
//  Effect.swift
//  VisualEffectTestProject
//
//  Created by kjs on 2021/12/27.
//

import UIKit

public protocol Readyable {
    init(for view: UIView)
}

public protocol Runable {
    func run()
}

public typealias Effect = Runable & Readyable