//
//  ViewController.swift
//  Bartender
//
//  Created by Igor Łopatka on 08/11/2022.
//

import UIKit

class DrinkListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchResultsUpdating {
    
    var drinks: [Drink] = []
    
    private var tableView: UITableView!
    private var search: UISearchController!
    private var segmentedControl: UISegmentedControl!
    private var activityView: UIActivityIndicatorView!
    
    var isSearchBarEmpty: Bool {
      return search.searchBar.text?.isEmpty ?? true
    }
    
    var isFiltering: Bool {
      return search.isActive && !isSearchBarEmpty
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let barHeight: CGFloat = self.navigationController!.navigationBar.frame.height
        let displayWidth: CGFloat = self.view.frame.width
        let displayHeight: CGFloat = self.view.frame.height
        
        tableView = UITableView(frame: CGRect(x: 0, y: barHeight, width: displayWidth, height: displayHeight - barHeight))
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "MyCell")
        tableView.dataSource = self
        tableView.delegate = self
        self.view.addSubview(tableView)
        
        search = UISearchController(searchResultsController: nil)
        search.searchResultsUpdater = self
        search.obscuresBackgroundDuringPresentation = false
        search.searchBar.barStyle = .default
        search.searchBar.placeholder = "What do you have in your bar?"
        definesPresentationContext = true
        
        segmentedControl = UISegmentedControl(items: SearchFor.allValues())
        segmentedControl.sizeToFit()
        segmentedControl.selectedSegmentIndex = 0
        
        activityView = UIActivityIndicatorView(style: .large)
        activityView.center = self.view.center
        activityView.isHidden = true
        activityView.hidesWhenStopped = true
        self.view.addSubview(activityView)
        
        navigationItem.titleView = segmentedControl
        navigationItem.searchController = search
        navigationItem.hidesSearchBarWhenScrolling = false
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = DrinkDetailsViewController()
        vc.drinkTitle = drinks[indexPath.row].strDrink
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return drinks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MyCell", for: indexPath as IndexPath)
        cell.textLabel!.text = "\(drinks[indexPath.row].strDrink)"
        return cell
    }
    
    func showActivityIndicator() {
        activityView.isHidden = false
        activityView.startAnimating()
    }
    
    func hideActivityIndicator() {
        activityView.stopAnimating()
    }
    
    func updateSearchResults(for searchController: UISearchController) {
        guard let text = searchController.searchBar.text else { return }
        if text != "" {
            DispatchQueue.main.async {
                self.fetchFilteredList(search: text)
            }
        }
    }
    
    // TheCoctailsDB API
    
    func fetchFilteredList(search: String)  {
                
        var urlString = ""
        
        switch segmentedControl.selectedSegmentIndex {
        case 0:
            urlString = "https://www.thecocktaildb.com/api/json/v1/1/search.php?s=\(search)"
        case 1:
            urlString = "https://www.thecocktaildb.com/api/json/v1/1/filter.php?i=\(search)"
        default:
            break
        }
        
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



