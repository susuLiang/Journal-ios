//
//  TableViewCell.swift
//  Journal
//
//  Created by Susu Liang on 2017/12/8.
//  Copyright © 2017年 Susu Liang. All rights reserved.
//

import UIKit

class MyJournalsTableViewCell: UITableViewCell {

    @IBOutlet weak var photoPlaced: UIImageView!
    @IBOutlet weak var journalTitle: UILabel!
    @IBOutlet weak var separatorView: UIView!

    override func awakeFromNib() {
        super.awakeFromNib()
        setUpSearatorView()
        setUpPhotoPlaced()

        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    func setUpSearatorView() {

        let view = separatorView!

        view.backgroundColor = UIColor(red: 171/255, green: 179/255, blue: 176/255, alpha: 1)

    }

    func setUpPhotoPlaced() {

        let view = photoPlaced!

        view.layer.cornerRadius = 8

    }

    func setUpJournalTitle() {

        let label = journalTitle!

        label.font = UIFont(name: "SFUIText", size: 14)

    }

}
