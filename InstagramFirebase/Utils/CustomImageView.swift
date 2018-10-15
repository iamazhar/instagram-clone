//
//  CustomImageView.swift
//  InstagramFirebase
//
//  Created by Azhar Anwar on 15/10/18.
//  Copyright © 2018 Azhar Anwar. All rights reserved.
//

import UIKit

class CustomeImageView: UIImageView {
    
    var lastURLUsedToLoadImage: String?
    
    func loadImage(urlString: String) {
        print("Loading Image: ")
        lastURLUsedToLoadImage = urlString
        guard let url = URL(string: urlString) else { return }
        
        URLSession.shared.dataTask(with: url) { (data, response, err) in
            if let err = err {
                print("Failed to fetch post image:", err.localizedDescription)
                return
            }
            
            if url.absoluteString != self.lastURLUsedToLoadImage { return }
            
            guard let imageData = data else { return }
            let photoImage = UIImage(data: imageData)
            DispatchQueue.main.async {
                self.image = photoImage
            }
            }.resume()
    }
}
