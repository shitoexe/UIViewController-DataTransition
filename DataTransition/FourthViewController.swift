//
//  FourthViewController.swift
//  DataTransition
//
//  Created by Alexey Shadura on 24/08/2017.
//  Copyright © 2017 IntellectSoft. All rights reserved.
//

import UIKit

class FourthViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        if let data = self.incomingData {
            print(data)
        }
    }

}
