//
//  Post.swift
//  InstagramFirebase
//
//  Created by Azhar Anwar on 15/10/18.
//  Copyright © 2018 Azhar Anwar. All rights reserved.
//

import Foundation

struct Post {
    
    var id: String?
    
    let user: User
    let imageUrl: String
    let caption: String
    let creationDate: Date
    
    var hasLiked = false
    
    init(user: User, dictionary: [String: Any]) {
        self.user = user
        self.imageUrl = dictionary["imageUrl"] as? String ?? ""
        self.caption = dictionary["caption"] as? String ?? ""
        
        let secondsFrom1970 = dictionary["creationDate"] as? Double ?? 0
        self.creationDate = Date(timeIntervalSince1970: secondsFrom1970)
    }
}
