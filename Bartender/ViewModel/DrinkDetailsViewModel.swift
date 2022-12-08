//
//  DrinkDetailsViewModel.swift
//  Bartender
//
//  Created by Igor Łopatka on 25/11/2022.
//

import Foundation

class DrinkDetailsViewModel: ObservableObject {
    
    let service: Service
    
    init(service: Service) {
        self.service = service
    }
    
    @Published var drinkID = ""
    @Published var drinkTitle = ""
    @Published var drinkWithDetails: Drink?
    
}
