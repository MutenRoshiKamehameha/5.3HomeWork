//
//  TabbarControllerViewController.swift
//  3HomeWork
//
//  Created by Байгелди Акылбек уулу on 10/2/23.
//

import UIKit

class TabbarViewController: UITabBarController{
    
    static let shared = TabbarViewController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.hidesBackButton = true
        setupTabbarVC()
    }
    
    
    private func setupTabbarVC() {
        
            viewControllers = [
                createControllers(for: MenuViewController(), title: "",
                                  image: UIImage(systemName: "house.fill")!),
                createControllers(for: BasketViewController(), title: "",
                                  image: UIImage(systemName: "basket.fill")!),
                createControllers(for: ProfileViewController(), title: "",
                                  image: UIImage(systemName: "person.fill")!)
                              ]
        }
        
    private func createControllers(
            for rootViewController: UIViewController,
            title: String,
            image: UIImage
        ) -> UIViewController {
            let navVC = UINavigationController(rootViewController: rootViewController)
            navVC.tabBarItem.title = title
            navVC.tabBarItem.image = image
            return navVC
    }
    
    
    

}





