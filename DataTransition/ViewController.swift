//
//  ViewController.swift
//  DataTransition
//
//  Created by Alexey Shadura on 18.10.16.
//  Copyright © 2016 IntellectSoft. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    
    let kNextControllerSegueIdentifier = "kNextControllerSegueIdentifier"
    let kModalControllerSegueIdentifier = "kModalControllerSegueIdentifier"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func forvardButtonDidTap(_ sender: UIButton) {
        
        self.segue(kNextControllerSegueIdentifier).onComplete{ parameter in
            
            if let stringParameter = parameter as? String{
                print(stringParameter)
            }
            
        }.passData("data for next view controller").execute()
    }
    
    @IBAction func modalButtonDidTap(_ sender: UIButton) {
        
        self.segue(kModalControllerSegueIdentifier).onComplete{ parameter in
            if let stringParameter = parameter as? String{
                print(stringParameter)
            }
            }.execute()
    }
    
}




