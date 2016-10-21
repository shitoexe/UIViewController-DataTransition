//
//  SecondViewController.swift
//  DataTransition
//
//  Created by Alexey Shadura on 18.10.16.
//  Copyright © 2016 IntellectSoft. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        if let r = self.incomingData() as? String {
            print("incoming \(r)")
        }
        

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func backButtonDidTap(_ sender: AnyObject) {
        self.complete("And Hello you")
        _ = (self.navigationController?.popViewController(animated: true))
    }

}
