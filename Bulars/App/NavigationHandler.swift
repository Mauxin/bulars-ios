//
//  navigationHandler.swift
//  Bulars
//
//  Created by Murilo Dias on 21/09/18.
//  Copyright © 2018 Murilo Dias. All rights reserved.
//
import UIKit

class NavigationHandler {
    
    static func tabController() -> UITabBarController {
        
        let tabBarController = UITabBarController()
        let home = HomeViewController()
        let profile = ProfileViewController()
        let homeNavigationController = UINavigationController(rootViewController: home)
        let profileNavigationController = UINavigationController(rootViewController: profile)
        let textAttributes = [NSAttributedStringKey.foregroundColor: UIColor.white]
        
        home.title = "BULARS"
        homeNavigationController.navigationBar.barTintColor = HexColor.from(hexValue: 0x56ACAC)
        homeNavigationController.navigationBar.tintColor = .white
        homeNavigationController.navigationBar.titleTextAttributes = textAttributes
        
        profile.title = "Perfil"
        profileNavigationController.navigationBar.barTintColor = HexColor.from(hexValue: 0x56ACAC)
        profileNavigationController.navigationBar.tintColor = .white
        profileNavigationController.navigationBar.titleTextAttributes = textAttributes
        
        let controllers = [homeNavigationController, profileNavigationController]
        tabBarController.viewControllers = controllers
        tabBarController.tabBar.tintColor = HexColor.from(hexValue: 0x56ACAC)
        
        home.tabBarItem = UITabBarItem(title: "Home", image: UIImage(named: "homeIcon"), tag: 1)
        profile.tabBarItem = UITabBarItem(title: "Perfil", image:UIImage(named: "profile"), tag:2)
        
        return tabBarController
    }
}
