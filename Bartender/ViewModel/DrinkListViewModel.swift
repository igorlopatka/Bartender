//
//  DrinkListViewModel.swift
//  Bartender
//
//  Created by Igor Łopatka on 25/11/2022.
//

import Foundation
import RxSwift


class DrinkListViewModel {
    
    let service: Servicing
    
    init(service: Servicing) {
        self.service = service
    }
    
    var drinks: [Drink] = []
    
    var search = ""
    var searchType: SearchFor = .ingredient
    var searchTypeURL: String {
        switch searchType {
        case .name:
            return "https://www.thecocktaildb.com/api/json/v1/1/search.php?s=\(search)"
        case .ingredient:
            return "https://www.thecocktaildb.com/api/json/v1/1/filter.php?i=\(search)"
        }
    }
}
