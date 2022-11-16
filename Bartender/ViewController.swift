//
//  ViewController.swift
//  Bartender
//
//  Created by Igor Łopatka on 08/11/2022.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchResultsUpdating {
    
    //Placeholder data
    let myArray = ["New York, NY", "Los Angeles, CA", "Chicago, IL", "Houston, TX",
            "Philadelphia, PA", "Phoenix, AZ", "San Diego, CA", "San Antonio, TX",
            "Dallas, TX", "Detroit, MI", "San Jose, CA", "Indianapolis, IN",
            "Jacksonville, FL", "San Francisco, CA", "Columbus, OH", "Austin, TX",
            "Memphis, TN", "Baltimore, MD", "Charlotte, ND", "Fort Worth, TX"]

    var filteredData: [String]!
    
    private var tableView: UITableView!
    private var search: UISearchController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let barHeight: CGFloat = UIApplication.shared.statusBarFrame.size.height
        let displayWidth: CGFloat = self.view.frame.width
        let displayHeight: CGFloat = self.view.frame.height
        
        tableView = UITableView(frame: CGRect(x: 0, y: barHeight, width: displayWidth, height: displayHeight - barHeight))
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "MyCell")
        tableView.dataSource = self
        tableView.delegate = self
        self.view.addSubview(tableView)
        
        search = UISearchController(searchResultsController: nil)
        search.searchResultsUpdater = self
        search.searchBar.backgroundColor = .red
        search.searchBar.barStyle = .default
        search.searchBar.placeholder = "What do you have in your bar?"
        search.obscuresBackgroundDuringPresentation = true
        
        navigationItem.searchController = search
        navigationItem.hidesSearchBarWhenScrolling = false
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("Num: \(indexPath.row)")
        print("Value: \(myArray[indexPath.row])")
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return myArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MyCell", for: indexPath as IndexPath)
        cell.textLabel!.text = "\(myArray[indexPath.row])"
        return cell
    }
    
    func updateSearchResults(for searchController: UISearchController) {
        guard let text = searchController.searchBar.text else { return }
        print(text)
    }
}

