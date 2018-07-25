//
//  NBAVC.swift
//  SportHuBMobile
//
//  Created by x on 5/29/18.
//  Copyright © 2018 x. All rights reserved.
//

import UIKit

class NBAVC: UIViewController {
    var tableData: [NSDictionary] = []
    
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        SportModel.getAllTasks(url: "http://localhost:8000/api") {
            data, response, error in
            do {
                if let jsonResult = try JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.mutableContainers) as? NSDictionary {
                    if let tasks = jsonResult["forums"] as? [NSDictionary] {
                        
                        for forum in tasks {
                            if forum["related_sport"] as! String == "NBA"{
                                self.tableData.append(forum)
                            }
                            
                        }
                        DispatchQueue.main.async {
                            self.tableView.reloadData()
                        }
                        
                        
                    }
                }
            } catch {
                print("Something wrong dude")
            }
        }
        
        tableView.dataSource = self
        tableView.delegate = self

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
       
        // Dispose of any resources that can be recreated.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showComment" {
            let nav = segue.destination as! UINavigationController
            let dest = nav.topViewController as! showCommentVC
            
            let indexPath = sender as! IndexPath
            
            let data = tableData[indexPath.row]
            dest.tableData = data
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "showComment", sender: indexPath)
    }


}

extension NBAVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "sportsCell", for: indexPath) as! sportsCellClass
        cell.mainLabel.text = tableData[indexPath.row]["title"] as? String
        return cell
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableData.count
    }
}
