//
//  DrinkDetailsViewModel.swift
//  Bartender
//
//  Created by Igor Łopatka on 25/11/2022.
//

import Foundation

class DrinkDetailsViewModel {
    
    let service: Servicing
    
    init(service: Servicing) {
        self.service = service
    }
    
    var drinkID = ""
    var drinkTitle = ""
    var drinkWithDetails: Drink?
    
}
