//
//  ViewController.swift
//  Journal
//
//  Created by Susu Liang on 2017/12/8.
//  Copyright © 2017年 Susu Liang. All rights reserved.
//

import UIKit
import Firebase

class MyJournalsController: UIViewController, UITableViewDelegate, UITableViewDataSource {

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

        Database.database().reference().child("Entry").observe(.value) { (snapshot) in

            self.journals = []

            if let objects = snapshot.children.allObjects as? [DataSnapshot] {

                for object in objects {
                    if let entry = object.value as? NSDictionary {
                        if
                            let title = entry["title"] as? String,
                            let content = entry["content"] as? String,
                            let imageURL = entry["imageURL"] as? String {
                            self.journals.append(Journal(title: title, content: content, urlString: imageURL))
                        }
                    }
                }
            }
        }
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as? MyJournalsTableViewCell else { fatalError() }

        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 212
    }

    func setUpPageTitle() {

        let label = pageTitleLabel!

        label.font = UIFont(name: "SFUIText", size: 20)

        label.font = UIFont.systemFont(ofSize: 20, weight: .semibold)

        label.tintColor = UIColor(red: 67/255, green: 87/255, blue: 97/255, alpha: 1)

    }

    @IBAction func back(segue: UIStoryboardSegue) {
    }

}
