//
//  MainTabController.swift
//  InstagramApp
//
//  Created by Vadim Kononenko on 21.07.2023.
//

import UIKit

class MainTabController: UITabBarController {
    
    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewControllers()
    }
    
    // MARK: - Helpers
    
    private func configureViewControllers() {
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
        let profile = templateNavigationController(
            unselectedImage: UIImage(named: "profile_unselected")!,
            selectedImage: UIImage(named: "profile_selected")!,
            rootViewController: ProfileViewController())
        
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
