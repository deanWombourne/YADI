//
//  ViewController.swift
//  YADI
//
//  Created by deanWombourne on 04/09/2022.
//  Copyright (c) 2022 deanWombourne. All rights reserved.
//

import UIKit

import YADI

class ViewController: UIViewController {

    @Inject var viewModel: ViewModel

    override func viewDidLoad() {
        super.viewDidLoad()

        print(self.viewModel)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
