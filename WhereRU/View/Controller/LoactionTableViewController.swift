//
//  LoactionTableViewController.swift
//  WhereRU
//
//  Created by 조성빈 on 2022/09/04.
//

import UIKit
import MapKit

class LoactionTableViewController: UITableViewController {
    
    let findPlaceView = FindPlaceView()
    
    var matchingItems: [MKMapItem] = []
    var mapView: MKMapView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return matchingItems.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: LocationTableViewCell.identifier, for: indexPath)
        return cell
    }
    
}

extension LoactionTableViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        guard let mapView = mapView,
              let searchBarText = searchController.searchBar.text else { return }
        let request = MKLocalSearch.Request()
        request.naturalLanguageQuery = searchBarText
        request.region = mapView.region
        let search = MKLocalSearch(request: request)
        search.start { response, _ in
            guard let response = response else {
                return
            }
            self.matchingItems = response.mapItems
            print(self.matchingItems)
            self.tableView.reloadData()
        }
    }
}
