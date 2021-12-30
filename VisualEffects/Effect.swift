//
//  Effect.swift
//  VisualEffectTestProject
//
//  Created by kjs on 2021/12/27.
//

import UIKit

protocol Readyable {
    func ready(for view: UIView) -> Effect
}

protocol Runable {
    func run()
}

typealias Effect = Runable & Readyable
