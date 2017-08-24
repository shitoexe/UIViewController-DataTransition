//
//  ThirdViewController.swift
//  DataTransition
//
//  Created by Alexey Shadura on 21.10.16.
//  Copyright © 2016 IntellectSoft. All rights reserved.
//

import UIKit

class ThirdViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func doneButtonDidTap(_ sender: AnyObject) {
        self.complete("data from modal VC")
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func nextButtonDidTap(_ sender: AnyObject) {
        self.segue("nextSegue").passData("data for 4th vc").execute()
    }

}
