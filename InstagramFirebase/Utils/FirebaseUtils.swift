//
//  FirebaseUtils.swift
//  InstagramFirebase
//
//  Created by Azhar Anwar on 17/10/18.
//  Copyright © 2018 Azhar Anwar. All rights reserved.
//

import Foundation
import Firebase

extension Database {
    static func fetchUserWithUID(uid: String, completion: @escaping (User) -> ()) {
        Database.database().reference().child("users").child(uid).observeSingleEvent(of: .value, with: { (snapshot) in
            
            guard let userDictionary = snapshot.value as? [String: Any] else { return }
            
            let user = User(uid: uid, dictionary: userDictionary)
            print(user.username)
            
            completion(user)
            
        }) { (err) in
            print("Error fetching user for post:", err.localizedDescription)
        }
        
    }
}
