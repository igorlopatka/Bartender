//
//  DrinkDetailsViewModel.swift
//  Bartender
//
//  Created by Igor Łopatka on 25/11/2022.
//

import Foundation

class DrinkDetailsViewModel: ObservableObject {
    
    let drink: Drink
    
    init(drink: Drink) {
        self.drink = drink
    }
    
    @Published private(set) var drinkID = ""
    @Published private(set) var drinkTitle = ""
    @Published private(set) var drinkCategory = ""
    @Published private(set) var drinkImageURL = ""
    
    func config() {
        drinkID = drink.idDrink
        drinkTitle = drink.strDrink
        drinkCategory = drink.strCategory
        drinkImageURL = drink.strDrinkThumb
    }
}
