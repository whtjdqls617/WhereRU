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
        let etcViewController = EtcViewController()
        
        let addFriendButton = UIBarButtonItem(image: UIImage(systemName: "plus"), style: .plain, target: self, action: #selector(pressAddFriendButton))
        let createButton = UIBarButtonItem(image: UIImage(systemName: "plus"), style: .plain, target: self, action: #selector(pressCreateButton))
        
        friendsViewController.navigationItem.title = "친구 목록"
        roomsViewController.navigationItem.title = "방 목록"
        
        friendsViewController.tabBarItem.image = UIImage(systemName: "person")
        friendsViewController.navigationItem.rightBarButtonItem = addFriendButton
        roomsViewController.tabBarItem.image = UIImage(systemName: "bubble.right")
        roomsViewController.navigationItem.rightBarButtonItem = createButton
        etcViewController.tabBarItem.image = UIImage(systemName: "ellipsis")

        let naviFriendsController = UINavigationController(rootViewController: friendsViewController)
        let naviRoomsController = UINavigationController(rootViewController: roomsViewController)
        let naviEtcController = UINavigationController(rootViewController: etcViewController)
        
        naviEtcController.isNavigationBarHidden = true
        
        setViewControllers([naviFriendsController, naviRoomsController, naviEtcController], animated: false)
    }
    
    @objc func pressAddFriendButton() {
        let addFriendVC = AddFriendViewController()
        let navController = UINavigationController(rootViewController: addFriendVC)
        navController.modalPresentationStyle = UIModalPresentationStyle.fullScreen
        present(navController, animated: true)
    }
    
    @objc func pressCreateButton() {
        let createRoomVC = CreateRoomViewController()
        let navController = UINavigationController(rootViewController: createRoomVC)
        navController.modalPresentationStyle = UIModalPresentationStyle.fullScreen
        present(navController, animated: true)
    }
}
