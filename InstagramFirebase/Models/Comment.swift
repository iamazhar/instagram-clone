//
//  Comment.swift
//  InstagramFirebase
//
//  Created by Azhar Anwar on 23/10/18.
//  Copyright © 2018 Azhar Anwar. All rights reserved.
//

import Foundation

struct Comment {
    let text: String
    let uid: String
    
    init(dictionary: [String : Any]) {
        self.text = dictionary["text"] as? String ?? ""
        self.uid = dictionary["uid"] as? String ?? ""
    }
}
