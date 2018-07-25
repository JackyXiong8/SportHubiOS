//
//  showCommentVC.swift
//  SportHuBMobile
//
//  Created by x on 5/29/18.
//  Copyright © 2018 x. All rights reserved.
//

import UIKit
import Foundation

class showCommentVC: UIViewController {
    var comments : [NSDictionary] = []
    var tableData : NSDictionary = [:]

    
    @IBOutlet weak var forumTitle: UILabel!
    @IBOutlet weak var forumDesc: UILabel!
    @IBOutlet weak var forumCreatedAt: UILabel!
    @IBOutlet weak var forumCreatedBy: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    @IBAction func backButton(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
    

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        let x = tableData["created_at"] as! String
//        print (x)
//        let dateFormatter = DateFormatter()
//        dateFormatter.dateFormat = "yyyy'-'MM'-'dd'T'HH':'mm':'ssZZZ"
//        let date = dateFormatter.date(from: (x))
//        print (date)
//
//        let newDateformatter = DateFormatter()
//        newDateformatter.dateFormat = "MMM d, h:mm a"
//        let newDate = newDateformatter.string(from: date!)
//        forumCreatedAt.text = newDate as? String
//
        
        
        forumTitle.text = tableData["title"] as? String
        forumDesc.text = tableData["description"] as? String
        forumCreatedAt.text = tableData["created_at"] as? String
        forumCreatedBy.text = tableData["created_by"] as? String


    
        
        
        
        
//        forumCreatedBy.text = formatter.string(from: tableData["created_at"] as! Date)

        tableView.dataSource = self
        tableView.delegate = self
        
        
        SportModel.getAllComments(url: "http://localhost:8000/commentsapi") {
            data, response, error in
            do {
                if let jsonResult = try JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.mutableContainers) as? NSDictionary {
                    if let comment = jsonResult["comments"] as? [NSDictionary] {
                        for id in comment {
                            if id["commented_on_id"] as? Int == self.tableData["id"] as? Int {
                                self.comments.append(id)
                                print(self.comments)
//                                print(self.comments)
                                
                            }
                        }
//                        print (comment)
                    }
                    DispatchQueue.main.async {
                        self.tableView.reloadData()
                    }
                }
            } catch {
                print ("Something wrong dude")
            }
        }
        
        
        tableView.rowHeight = 100
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

extension showCommentVC: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "commentCell", for: indexPath) as! commentCellClass
        cell.commentLabel.text = comments[indexPath.row]["content"] as? String
        cell.created_atLabel.text = comments[indexPath.row]["created_at"] as? String
        cell.created_byLabel.text = comments[indexPath.row]["commented_by"] as? String
        
        return cell
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return comments.count
    }
    
}
