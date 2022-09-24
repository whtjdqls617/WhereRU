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
//        print(roomsList)
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
    }
}

extension RoomsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return roomsList?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: RoomsTableViewCell.identifier, for: indexPath) as? RoomsTableViewCell else {return UITableViewCell()}
        
        cell.name = roomsList?[indexPath.row].name ?? ""
        cell.totalCountOfPeopleLabel.text = String(roomsList?[indexPath.row].friends.count ?? 0)
        cell.placeLabel.text = roomsList?[indexPath.row].location.name
        return cell
    }
}

extension RoomsViewController: UITableViewDelegate {
    
}
