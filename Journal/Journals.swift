//
//  Journals.swift
//  Journal
//
//  Created by Susu Liang on 2017/12/8.
//  Copyright © 2017年 Susu Liang. All rights reserved.
//

import Foundation

struct Journal {
    
    let id: String

    let title: String

    let content: String
    
    let date: String

    let urlString: String

}

extension Journal {

    var imageURL: URL {

        return URL(string: urlString)!

    }

}
