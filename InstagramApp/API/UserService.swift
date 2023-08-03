//
//  UserService.swift
//  InstagramApp
//
//  Created by Vadim Kononenko on 26.07.2023.
//

import FirebaseAuth

class UserService {
    static func fetchUser(completion: @escaping(User) -> ()) {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        
        COLLECTION_USERS.document(uid).getDocument { snapshot, error in
            guard let dicrionary = snapshot?.data() else { return }
            let user = User(dictionary: dicrionary)
            completion(user)
        }
    }
}
