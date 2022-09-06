//
//  LoactionTableViewController.swift
//  WhereRU
//
//  Created by 조성빈 on 2022/09/04.
//

import UIKit
import NMapsMap

class LoactionTableViewController: UITableViewController {
    
    let findPlaceView = FindPlaceView()
    
//    var matchingItems: [MKMapItem] = []
    var mapView: NMFMapView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(LocationTableViewCell.self, forCellReuseIdentifier: LocationTableViewCell.identifier)
    }
}

extension LoactionTableViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        guard let mapView = mapView,
              let searchBarText = searchController.searchBar.text else { return }
        
    }
}

extension LoactionTableViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: LocationTableViewCell.identifier, for: indexPath) as? LocationTableViewCell else {return UITableViewCell()}
//        cell.nameLabel.text = matchingItems[indexPath.row].name
        return cell
    }
}
