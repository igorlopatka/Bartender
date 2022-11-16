//
//  Drink.swift
//  Bartender
//
//  Created by Igor Łopatka on 16/11/2022.
//

import Foundation

struct Drinks: Codable {
    let drinks: [Drink]
}

struct Drink: Codable, Hashable {
    let strDrink: String
    let strDrinkThumb: String
    let idDrink: String
}
