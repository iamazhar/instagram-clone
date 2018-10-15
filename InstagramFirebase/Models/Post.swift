//
//  Post.swift
//  InstagramFirebase
//
//  Created by Azhar Anwar on 15/10/18.
//  Copyright © 2018 Azhar Anwar. All rights reserved.
//

import Foundation

struct Post {
    let imageUrl: String
    
    init(dictionary: [String: Any]) {
        self.imageUrl = dictionary["imageUrl"] as? String ?? ""
    }
}
