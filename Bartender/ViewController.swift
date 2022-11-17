//
//  ViewController.swift
//  Bartender
//
//  Created by Igor Łopatka on 08/11/2022.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchResultsUpdating {
    
    var drinks: [Drink] = []
    
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
        search.searchBar.barStyle = .default
        search.searchBar.placeholder = "What do you have in your bar?"
        search.obscuresBackgroundDuringPresentation = true
        
        navigationItem.searchController = search
        navigationItem.hidesSearchBarWhenScrolling = false
        
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("Num: \(indexPath.row)")
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return drinks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MyCell", for: indexPath as IndexPath)
        cell.textLabel!.text = "\(drinks[indexPath.row].strDrink)"
        return cell
    }
    
    func updateSearchResults(for searchController: UISearchController) {
        guard let text = searchController.searchBar.text else { return }
        if text != "" {
            DispatchQueue.main.async {
                self.fetchDrinkList(search: text)
            }
        }
    }
    
    // TheCoctailsDB API
    
    func fetchDrinkList(search: String)  {
        
        let urlString: String
        
        //        switch searchFor {
        //        case .name:
        urlString = "https://www.thecocktaildb.com/api/json/v1/1/search.php?s=\(search)"
        //        case .ingredient:
        //            urlString = "https://www.thecocktaildb.com/api/json/v1/1/filter.php?i=\(search)"
        //        }
        
        
        
        let url = URL(string: urlString)!
        let session = URLSession.shared
        let request = URLRequest(url: url)
        let task = session.dataTask(with: request as URLRequest, completionHandler: { [self] data, response, error in
            guard error == nil else {
                return
            }
            guard let data = data else {
                return
            }
            do {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                let response = try decoder.decode(Drinks.self, from: data)
                drinks = response.drinks
                self.tableView.reloadData()
                
            } catch {
                print(error)
            }
        })
        task.resume()
    }
}



