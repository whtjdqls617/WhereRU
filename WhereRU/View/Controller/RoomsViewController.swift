//
//  RoomsViewController.swift
//  WhereRU
//
//  Created by 조성빈 on 2022/09/01.
//

import UIKit
import Combine

class RoomsViewController: BaseViewController {

    private let roomsView = RoomsView()
    private let roomsViewModel = RoomsViewModel()
    
    var roomsList : [Room]?
    var friendsInRoomList : [[FriendInRoom]]?
    private var disposalbleBag = Set<AnyCancellable>()
    
    override func loadView() {
        super.loadView()
        self.view = roomsView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        roomsView.roomTableView.dataSource = self
        roomsView.roomTableView.delegate = self
        
        setBinding()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        roomsViewModel.getRoomdDataFromFirestore()
    }
    
}

extension RoomsViewController {
    private func setBinding() {
        self.roomsViewModel.$roomsList.sink { [weak self] updatedRoomsList in
            self?.roomsList = updatedRoomsList
            DispatchQueue.main.async {
                self?.roomsView.roomTableView.reloadData()
            }
        }.store(in: &disposalbleBag)
        self.roomsViewModel.$friendsInRoomList.sink { [weak self] updatedFriendsInRoomList in
            self?.friendsInRoomList = updatedFriendsInRoomList
            DispatchQueue.main.async {
                self?.roomsView.roomTableView.reloadData()
            }
        }.store(in: &disposalbleBag)
    }
}

extension RoomsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return roomsList?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: RoomsTableViewCell.identifier, for: indexPath) as? RoomsTableViewCell else {return UITableViewCell()}
        
        cell.name = roomsList?[indexPath.row].name ?? ""
        let count : String = String(roomsList?[indexPath.row].friends.count ?? 0)
        cell.totalCountOfPeopleLabel.text = count
        cell.placeLabel.text = roomsList?[indexPath.row].location.name
        return cell
    }
}

extension RoomsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let roomVC = EnteredRoomViewController()
        navigationController?.pushViewController(roomVC, animated: true)
        
        roomVC.friends = roomsList?[indexPath.row].friends
        roomVC.placeName = roomsList?[indexPath.row].location.name ?? ""
        roomVC.placeCoordinate = roomsList?[indexPath.row].location.coordinate ?? []
        roomVC.money = roomsList?[indexPath.row].money ?? 0
        roomVC.roomName = roomsList?[indexPath.row].name ?? ""
    }
}
