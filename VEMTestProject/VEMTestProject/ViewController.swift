//
//  ViewController.swift
//  VEMTestProject
//
//  Created by kjs on 2021/12/20.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.view.layer.backgroundColor = UIColor.darkGray.cgColor

        VEM.particle.withSnow.ready(for: self.view).run()
    }
}
