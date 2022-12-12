//
//  DrinkDetailsViewModel.swift
//  Bartender
//
//  Created by Igor Łopatka on 25/11/2022.
//

import Foundation

class DrinkDetailsViewModel: ObservableObject {
    
    let drink: Drink
    let service: Service
    
    init(drink: Drink, service: Service) {
        self.drink = drink
        self.service = service
    }
    
    @Published var drinkID = ""
    @Published var drinkTitle = ""
}
