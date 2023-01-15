//
//  ViewController.swift
//  Bartender
//
//  Created by Igor Łopatka on 08/11/2022.
//

import Combine
import Kingfisher
import UIKit

class DrinkListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchResultsUpdating {
    
    // MVVM - ViewModel
    private var vm = DrinkListViewModel(service: TheCocktailsDBService())

    // Bindings - Publisher
    private var cancellables = Set<AnyCancellable>()

    // MVVM - Bindings

    private func bind() {
        vm.$drinks
            .receive(on: DispatchQueue.main)
            .sink { [weak self] _ in
                self?.tableView.reloadData()
            }
            .store(in: &cancellables)
        
        vm.$search
            .receive(on: DispatchQueue.main)
            .sink { [weak self] _ in
                self?.vm.fetchDrinksList()
            }
            .store(in: &cancellables)
        
        vm.$searchType
            .receive(on: DispatchQueue.main)
            .sink { [weak self] _ in
                self?.vm.fetchDrinksList()
            }
            .store(in: &cancellables)
    }

    private var tableView: UITableView!
    private var search: UISearchController!
    private var segmentedControl: UISegmentedControl!
    private var activityView: UIActivityIndicatorView!
    
    private var isSearchBarEmpty: Bool {
      return search.searchBar.text?.isEmpty ?? true
    }
    
    private var isFiltering: Bool {
      return search.isActive && !isSearchBarEmpty
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        bind()
        
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
    
    // MARK: - TableView
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = DrinkDetailsViewController()
        vc.drinkTitle = vm.drinks[indexPath.row].strDrink
        vc.drinkID = vm.drinks[indexPath.row].idDrink
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return vm.drinks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MyCell", for: indexPath as IndexPath)
        
        cell.textLabel!.text = "\(self.vm.drinks[indexPath.row].strDrink)"
        cell.imageView?.kf.indicatorType = .activity
        cell.imageView?.kf.setImage(with: URL(string: self.vm.drinks[indexPath.row].strDrinkThumb))
        
        return cell
    }
    
    //MARK: - Activity Indicator
    
    func showActivityIndicator() {
        activityView.isHidden = false
        activityView.startAnimating()
    }
    
    func hideActivityIndicator() {
        activityView.stopAnimating()
    }
    
    func updateSearchResults(for searchController: UISearchController) {
        vm.search = searchController.searchBar.text ?? ""
        if isFiltering {
            DispatchQueue.main.async {
                self.vm.fetchDrinksList()
            }
        } 
    }
}



