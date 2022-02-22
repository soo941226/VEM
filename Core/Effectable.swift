//
//  Effectable.swift
//  VEMTestProject
//
//  Created by kjs on 2021/12/27.
//

#if os(iOS)
import UIKit

public protocol Readyable {
    init(for view: UIView)
}

public protocol Runable {
    func run() -> Stopable
}

public protocol Stopable {
    var marginToDeleteAfterStop: TimeInterval { get set }
    func stop(immediately: Bool)
}

public typealias Effectable = Runable & Readyable & Stopable
#endif
