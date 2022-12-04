//
//  DrinkDetailsViewModel.swift
//  Bartender
//
//  Created by Igor Łopatka on 25/11/2022.
//

import Foundation

class DrinkDetailsViewModel {
    
    let service: Service
    
    init(service: Service) {
        self.service = service
    }
    
    var drinkID = ""
    var drinkTitle = ""
    var drinkWithDetails: Drink?
    
}
