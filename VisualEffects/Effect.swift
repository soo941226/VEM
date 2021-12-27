//
//  Effect.swift
//  VisualEffectTestProject
//
//  Created by kjs on 2021/12/27.
//

import UIKit

protocol ReadyableEffect {
    func ready(for view: UIView) -> Effect
}

protocol RunableEffect {
    func run()
}

typealias Effect = RunableEffect & ReadyableEffect
