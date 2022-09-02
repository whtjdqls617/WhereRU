//
//  TabBarViewController.swift
//  WhereRU
//
//  Created by 조성빈 on 2022/09/01.
//

import UIKit

class TabBarViewController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let friendsViewController = FriendsViewController()
        let roomsViewController = RoomsViewController()
        let settingViewController = SettingViewController()
        
        let createButton = UIBarButtonItem(image: UIImage(systemName: "plus"), style: .plain, target: self, action: #selector(pressCreateButton))
        
        friendsViewController.navigationItem.title = "친구 목록"
        roomsViewController.navigationItem.title = "방 목록"
        
        friendsViewController.tabBarItem.image = UIImage(systemName: "person")
        roomsViewController.tabBarItem.image = UIImage(systemName: "bubble.right")
        roomsViewController.navigationItem.rightBarButtonItem = createButton
        settingViewController.tabBarItem.image = UIImage(systemName: "ellipsis")

        let naviFriendsController = UINavigationController(rootViewController: friendsViewController)
        let naviRoomsController = UINavigationController(rootViewController: roomsViewController)
        let naviSettingController = UINavigationController(rootViewController: settingViewController)
        
//        naviFriendsController.isNavigationBarHidden = true
//        naviRoomsController.isNavigationBarHidden = true
        naviSettingController.isNavigationBarHidden = true
        
        setViewControllers([naviFriendsController, naviRoomsController, naviSettingController], animated: false)
    }
    
    @objc func pressCreateButton() {
        let createRoomVC = CreateRoomViewController()
        createRoomVC.modalPresentationStyle = UIModalPresentationStyle.fullScreen
        present(createRoomVC, animated: true)
    }
}
