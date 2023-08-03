//
//  MainTabController.swift
//  InstagramApp
//
//  Created by Vadim Kononenko on 21.07.2023.
//

import UIKit
import FirebaseAuth

class MainTabController: UITabBarController {
    
    // MARK: - Properties
    
    private var user: User? {
        didSet {
            guard let user = user else { return }
            configureViewControllers(withUser: user)
        }
    }
    
    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()

        checkIfUserLoggedIn()
        fecthUser()
    }
    
    // MARK: - API
    
    private func fecthUser() {
        UserService.fetchUser() { user in
            self.user = user
        }
    }
    
    private func checkIfUserLoggedIn() {
        if Auth.auth().currentUser == nil {
            DispatchQueue.main.async {
                let controller = LoginViewController()
                controller.delegate = self
                let nav = UINavigationController(rootViewController: controller)
                nav.modalPresentationStyle = .fullScreen
                self.present(nav, animated: true)
            }
        }
    }
    
    // MARK: - Helpers
    
    private func configureViewControllers(withUser user: User) {
        let layout = UICollectionViewFlowLayout()
        let feed = templateNavigationController(
            unselectedImage: UIImage(named: "home_unselected")!,
            selectedImage: UIImage(named: "home_selected")!,
            rootViewController: FeedViewController(collectionViewLayout: layout))
        
        let search = templateNavigationController(
            unselectedImage: UIImage(named: "search_unselected")!,
            selectedImage: UIImage(named: "search_selected")!,
            rootViewController: SearchViewController())
        
        let imageSelector = templateNavigationController(
            unselectedImage: UIImage(named: "plus_unselected")!,
            selectedImage: UIImage(named: "plus_unselected")!,
            rootViewController: ImageSelectorViewController())
        
        let notifications = templateNavigationController(
            unselectedImage: UIImage(named: "like_unselected")!,
            selectedImage: UIImage(named: "like_selected")!,
            rootViewController: NotificationViewController())
        
        let profileController = ProfileViewController(user: user)
        let profile = templateNavigationController(
            unselectedImage: UIImage(named: "profile_unselected")!,
            selectedImage: UIImage(named: "profile_selected")!,
            rootViewController: profileController)
        
        viewControllers = [feed, search, imageSelector, notifications, profile]
        
        tabBar.tintColor = .black
    }
    
    func templateNavigationController(unselectedImage: UIImage, selectedImage: UIImage, rootViewController: UIViewController) -> UINavigationController {
        let nav = UINavigationController(rootViewController: rootViewController)
        nav.tabBarItem.image = unselectedImage
        nav.tabBarItem.selectedImage = selectedImage
        nav.navigationBar.tintColor = .black
        return nav
    }

}

extension MainTabController: AuthenticationDelegate {
    func authenticationDidComplete() {
        fecthUser()
        self.dismiss(animated: true)
    }
}
