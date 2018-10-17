//
//  User.swift
//  InstagramFirebase
//
//  Created by Azhar Anwar on 17/10/18.
//  Copyright © 2018 Azhar Anwar. All rights reserved.
//

import Foundation

struct User {
    let username: String
    let profileImageUrl: String
    
    init(dictionary: [String: Any]) {
        self.username = dictionary["username"] as? String ?? ""
        self.profileImageUrl = dictionary["profileImageUrl"] as? String ?? ""
    }
}
