//
//  MainNavigationController.swift
//  genme
//
//  Created by Emirhan Karahan on 12.08.2023.
//

import UIKit

final class MainNavigationController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()
        viewControllers = [HomeViewController()]
    }

}
