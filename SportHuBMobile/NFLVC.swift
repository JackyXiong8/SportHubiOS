//
//  NFLVC.swift
//  SportHuBMobile
//
//  Created by x on 5/29/18.
//  Copyright © 2018 x. All rights reserved.
//

import UIKit

class NFLVC: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    
    var tableData: [NSDictionary] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        
        tableView.delegate = self
        tableView.dataSource = self
        
        SportModel.getAllTasks(url: "http://localhost:8000/api") {
            data, response, error in
            do {
                if let jsonResult = try JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.mutableContainers) as? NSDictionary {
                    if let tasks = jsonResult["forums"] as? [NSDictionary] {
                        
                        for forum in tasks {
                            if forum["related_sport"] as! String == "NFL"{
                                self.tableData.append(forum)
                                print(self.tableData)
                                
                                
                            }
                            
                        }
                        DispatchQueue.main.async {
                            self.tableView.reloadData()
                        }
                        
                        
                    }
                }
            } catch {
                print("something went wrong")
            }
        }

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "showComment", sender: indexPath)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showComment"{
            
            let nav = segue.destination as! UINavigationController
            let dest = nav.topViewController as! showCommentVC
            
            let indexPath = sender as! IndexPath
            
            let forum = tableData[indexPath.row]
            dest.tableData = forum
            
        }
    }

}

extension NFLVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "sportsCell", for: indexPath) as! sportsCellClass
        cell.mainLabel.text = tableData[indexPath.row]["title"] as? String
        return cell
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableData.count
    }
}
