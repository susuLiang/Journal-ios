//
//  ViewController.swift
//  Journal
//
//  Created by Susu Liang on 2017/12/8.
//  Copyright © 2017年 Susu Liang. All rights reserved.
//

import UIKit
import Firebase
import Nuke

class MyJournalsController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    //MARK: Property
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var pageTitleLabel: UILabel!
    
    @IBOutlet weak var addButton: UIButton!
    
    var journals: [Journal] = []
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        setUpPageTitle()
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
      
        let connectedRef = Database.database().reference(withPath: ".info/connected")
        
        connectedRef.observe(.value, with: { snapshot in
            
            if snapshot.value as? Bool ?? false {
                print("Connected")
                self.tableView.reloadData()
            } else {
                print("Not connected")
            }
            
        })
        
        Database.database().reference().child("Entry").observe(.value) { (snapshot) in


            if let objects = snapshot.children.allObjects as? [DataSnapshot] {
                self.journals = []
                for object in objects {
                    if let entry = object.value as? NSDictionary,
                        let id = object.key as? String {
                        if
                            let title = entry["title"] as? String,
                            let content = entry["content"] as? String,
                            let imageURL = entry["imageURL"] as? String,
                            let date = entry["date"] as? String {
                            self.journals.append(Journal(id: id,title: title, content: content, date: date, urlString: imageURL))
                            self.journals.sort() { $0.date > $1.date }
                        }
                    }
                }
                self.tableView.reloadData()
            }
        }
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return journals.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as? MyJournalsTableViewCell else { fatalError() }
        
        cell.journalTitle.text = journals[indexPath.row].title
        
        Nuke.loadImage(with: journals[indexPath.row].imageURL , into: cell.photoPlaced)
        
        
        
        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 212
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        
        if editingStyle == .delete {
            
                let ref = Database.database().reference().child("Entry").child("\(self.journals[indexPath.row].id)")
                ref.removeValue()
            
        }
    }
    
 
    func setUpPageTitle() {

        let label = pageTitleLabel!

        label.font = UIFont(name: "SFUIText", size: 20)

        label.font = UIFont.systemFont(ofSize: 20, weight: .semibold)

        label.tintColor = UIColor(red: 67/255, green: 87/255, blue: 97/255, alpha: 1)
        
        label.frame.origin.x = 20

    }
    

    @IBAction func back(segue: UIStoryboardSegue) {
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showCell" {
            
            if let showVC = segue.destination as? AddNewController {
                if let journal = sender as? Journal {
                    showVC.journal = journal
                    print(showVC.journal)
                }
            }
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            performSegue(withIdentifier: "showCell", sender: journals[indexPath.row])
    }
}
