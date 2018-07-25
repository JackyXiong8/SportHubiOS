//
//  ViewController.swift
//  SportHuBMobile
//
//  Created by x on 5/22/18.
//  Copyright © 2018 x. All rights reserved.
//

import UIKit

class logInVC: UIViewController {
    @IBOutlet weak var mainImage: UIImageView!

    @IBOutlet weak var emailInput: UITextField!
    
    @IBOutlet weak var passwordInput: UITextField!
    
    @IBAction func logInButton(_ sender: UIButton) {
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "logInSegue" {
            let barViewControllers = segue.destination as! UITabBarController
            let nav = barViewControllers.viewControllers![0] as! UINavigationController
            let destinationViewController = nav.topViewController as! mainHubVC
            
            destinationViewController.name = emailInput.text
            self.emailInput.text = nil
            self.passwordInput.text = nil
            
        } else {
            
        }
      
    }
//
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

