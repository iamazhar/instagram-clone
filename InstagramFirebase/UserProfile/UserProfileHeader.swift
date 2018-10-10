//
//  UserProfileHeader.swift
//  InstagramFirebase
//
//  Created by Azhar Anwar on 10/10/18.
//  Copyright © 2018 Azhar Anwar. All rights reserved.
//

import UIKit
import Firebase

class UserProfileHeader: UICollectionViewCell {
    
    let profileImageView: UIImageView = {
        let iv = UIImageView()
        iv.backgroundColor = .red
        return iv
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .blue
        addSubview(profileImageView)
        profileImageView.anchor(top: topAnchor, left: leftAnchor, bottom: nil, right: nil, paddingTop: 12, paddingLeft: 12, paddingBottom: 0, paddingRight: 0, width: 80, height: 80)
        profileImageView.layer.cornerRadius = 80 / 2
        profileImageView.clipsToBounds = true
    }
    
    var user: User? {
        didSet{
            setupProfileImage()
        }
    }
    
    fileprivate func setupProfileImage() {
        print("Did set \(user?.username ?? "")")
        
        guard let profileImageUrl = user?.profileImageUrl else { return }
        
        guard let url = URL(string: profileImageUrl) else { return }
        
        URLSession.shared.dataTask(with: url) { (data, response, err) in
            //Check for the erro, then construct the image using data
            if let err = err {
                print("Failed to fetch profile image:", err)
            }
            
            //TODO: - Check for response status of 200 (HTTP OK)
            
            guard let data = data else { return }
            
            let image = UIImage(data: data)
            
            DispatchQueue.main.async {
                self.profileImageView.image = image
            }
            
            }.resume()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
