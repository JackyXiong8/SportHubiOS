//
//  registerVC.swift
//  SportHuBMobile
//
//  Created by x on 5/30/18.
//  Copyright © 2018 x. All rights reserved.
//

import UIKit


class registerVC: UIViewController {
    
    @IBOutlet weak var errorLabel: UILabel!
    @IBOutlet weak var firstNameInput: UITextField!
    @IBOutlet weak var lastNameInput: UITextField!
    @IBOutlet weak var emailInput: UITextField!
    @IBOutlet weak var passwordInput: UITextField!
    @IBOutlet weak var passwordConfirm: UITextField!
    
    @IBAction func registerButton(_ sender: UIButton) {
      sendData()
        
        
        
    }
    
    var newUser:NSDictionary?
    
    func sendData() {
        
        let userInfo = [
            "first_name" : firstNameInput.text!,
            "last_name" : lastNameInput.text!,
            "email" : emailInput.text!,
            "password" : passwordInput.text!,
            "confirm_password" : passwordConfirm.text!]

        
        let url = URL(string: "http://localhost:8000/registerios")
        
        let session = URLSession.shared
        
        let request = NSMutableURLRequest(url: url!)
        
        request.httpMethod = "POST"
        
        let jsonData = try? JSONSerialization.data(withJSONObject: userInfo, options: .prettyPrinted)
        
        
        request.setValue("application/json; charset=utf-8", forHTTPHeaderField: "Content-Type")
        request.httpBody = jsonData
        
        let task = session.dataTask(with: request as URLRequest) {
            data, response, error in
            
            guard let _:NSData = data as NSData?, let _:URLResponse = response, error == nil else {
                print ("error")
                return
            }
            do {
            if let dataString = try JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.mutableContainers) as? NSDictionary
            {
                if let error = dataString["errors"] as? NSDictionary {
                    print (error)
                    let firstKey = Array(error.allValues)[0]
                    
                    DispatchQueue.main.async {
                        self.errorLabel.text = firstKey as? String
                    }
                } else {
                    
                    let newUserInfo = dataString
                    
                    
                    DispatchQueue.main.async {
                        self.performSegue(withIdentifier: "successfullRegister", sender: newUserInfo)
                        self.newUser = dataString
                    }
                    
            }
                
            }
            }
            catch {
                print("error")
            }
        }
        task.resume()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "successfullRegister" {
            let nav = segue.destination as! UINavigationController
            let dest = nav.topViewController as! mainHubVC
            
            
            dest.nameLabel.text = newUser!["first_name"] as? String
        }
    }
    
    
    
    @IBAction func cancelButton(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        errorLabel.text = nil
        

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func uploadData(data: [String: Any], completionHandler:@escaping (Bool) ->()){
        let url = "localhost:8000/registerios"
        var request = URLRequest(url: URL.init(string: url)!)
        
        request.httpMethod = "POST"
        
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        request.httpBody = try! JSONSerialization.data(withJSONObject: data)
    }
}
