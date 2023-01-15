//
//  DrinkListViewModel.swift
//  Bartender
//
//  Created by Igor Łopatka on 25/11/2022.
//

import Combine
import Foundation

class DrinkListViewModel: ObservableObject {
    
    let service: Service
    
    init(service: Service) {
        self.service = service
    }
  
    @Published private(set) var drinks: [Drink] = []
    @Published var searchType: SearchFor = .ingredient
    @Published var search = ""

    var searchTypeURL: String {
        switch searchType {
        case .name:
            return "search.php?s="
        case .ingredient:
            return "filter.php?i="
        }
    }
    
    func fetchDrinksList() {
        service.fetchFilteredList(type: searchTypeURL, search: search) { result in
            self.drinks = result
        }
    }
}
