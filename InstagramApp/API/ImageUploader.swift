//
//  ImageUploader.swift
//  InstagramApp
//
//  Created by Vadim Kononenko on 24.07.2023.
//

import FirebaseStorage
import UIKit.UIImage

struct ImageUploader {
    static func uploadImage(image: UIImage, comletion: @escaping(String) -> ()) {
        guard let imageData = image.jpegData(compressionQuality: 0.75) else { return }
        
        let filename = UUID().uuidString
        let ref = Storage.storage().reference(withPath: "/profile_images/\(filename)")
        
        ref.putData(imageData) { metadata, error in
            if let error = error {
                print("Failed to upload image: \(error.localizedDescription)")
                return
            }
            
            ref.downloadURL { url, error in
                guard let imageUrl = url?.absoluteString else { return }
                comletion(imageUrl)
            }
        }
    }
}
