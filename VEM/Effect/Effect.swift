//
//  Effect.swift
//  VEMTestProject
//
//  Created by kjs on 2021/12/27.
//

import UIKit

public protocol Readyable {
    init(for view: UIView)
}

public protocol Runable {
    func run() -> Stopable
}

public protocol Stopable {
    func stop()
}

public typealias Effect = Runable & Readyable & Stopable
