//
//  PlantListTableViewController.swift
//  TTFFCamp
//
//  Created by yanze on 3/22/16.
//  Copyright © 2016 The Taylor Family Foundation. All rights reserved.
//

import UIKit

class PlantListTableViewController: UITableViewController, UISearchResultsUpdating, UISearchBarDelegate {
    
    var singlePlant = Plant()
    var allPlants: [Plant] = []
    // variables for the search bar
    var searchController = UISearchController(searchResultsController: nil)
    var filteredPlants = [Plant]()
    var detectedText = ""
    
    @IBAction func backButtonPressed(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }

    override func viewDidLoad() {
        print("PlantListTableViewController loaded")
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        self.navigationItem.setHidesBackButton(true, animated: false)
        
        // search bar tasks
        searchController.searchResultsUpdater = self
        searchController.dimsBackgroundDuringPresentation = false
        definesPresentationContext = true
        tableView.tableHeaderView = searchController.searchBar
        
        // get all plants from local storage
        allPlants = Database.all()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // dequeue cell from storyboard
        let cell = tableView.dequeueReusableCell(withIdentifier: "PlantCell")!
        
        // set note variable represent an instance of a Plant
        let plant: Plant
        
        // check to see if user is using the search bar
        // set note variable to represent objects of Plant in each index of array, with the index counting in descending order
        if searchController.isActive && searchController.searchBar.text != "" {
            // use filteredPlants if search is taking place
            plant = filteredPlants[indexPath.row]
        } else {
            // else print out all the notes
            plant = allPlants[indexPath.row]
        }
        
        
        // set entry and date label in each cell
        cell.textLabel!.text = plant.plantName
        cell.detailTextLabel!.text = plant.location
        
        // return a UITableViewCell
        return cell
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        allPlants = Database.all()
        
        if searchController.isActive && searchController.searchBar.text != "" {
            return filteredPlants.count
        }
        
        return allPlants.count
    }
    
    
    // SEARCH BAR FUNCTIONS
    func updateSearchResults(for searchController: UISearchController) {
        filterContentForSearchText(searchController.searchBar.text!)
    }
    
    func filterContentForSearchText(_ searchText: String, scope: String = "All") {
        filteredPlants = allPlants.filter { plant in
            return plant.plantName.lowercased().contains(searchText.lowercased())
        }
        
        tableView.reloadData()
    }
    
    
    // Prepare segue to Plant Info View
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier! == "showInfoFromList"){
            
            let plantInfoVC = segue.destination as! PlantInfoViewController
            
            // Sender is the cell that gets selected by the user
            let cell = sender as! UITableViewCell
            
            // Unwrap the text from the cell and pass it through the segue to the PlantInfoViewController
            if let text = cell.textLabel!.text {
                plantInfoVC.detectedText = text
            }

        }
    }


}
