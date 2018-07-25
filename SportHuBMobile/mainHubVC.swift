//
//  mainHubVC.swift
//  SportHuBMobile
//
//  Created by x on 5/29/18.
//  Copyright © 2018 x. All rights reserved.
//

import UIKit

class mainHubVC: UIViewController {
    @IBAction func logOutButton(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
        
    }
    
    @IBOutlet weak var nameLabel: UILabel!
    var name: String? = nil

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
