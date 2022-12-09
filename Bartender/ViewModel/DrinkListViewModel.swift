//
//  DrinkListViewModel.swift
//  Bartender
//
//  Created by Igor Łopatka on 25/11/2022.
//

import Foundation
import RxSwift


class DrinkListViewModel: ObservableObject {
    
    let service: Service
    
    init(service: Service) {
        self.service = service
    }
    
    @Published var drinks: [Drink] = []
    @Published var search = ""
    @Published var searchType: SearchFor = .ingredient
    
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
