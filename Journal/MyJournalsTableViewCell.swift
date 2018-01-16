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
    @IBOutlet weak var showCellButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setUpSearatorView()
        setUpPhotoPlaced()

    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        
        super.setSelected(selected, animated: animated)

    }

    func setUpSearatorView() {

        let view = separatorView!

        view.backgroundColor = UIColor(red: 171/255, green: 179/255, blue: 176/255, alpha: 1)

    }

    func setUpPhotoPlaced() {

        let view = photoPlaced!

        view.layer.cornerRadius = 8
        
        view.contentMode = .scaleAspectFill
        
        view.clipsToBounds = true

    }

    func setUpJournalTitle() {

        let label = journalTitle!

        label.font = UIFont(name: "SFUIText", size: 14)

    }

}
