//
//  DrinkDetailView.swift
//  Bartender
//
//  Created by Igor Łopatka on 10/06/2022.
//

import SwiftUI

struct DrinkDetailView: View {
    
    let drink: Drink
    
    var body: some View {
        VStack {
            AsyncImage(url: URL(string: drink.strDrinkThumb)) { image in
                image.resizable()
            } placeholder: {
                Color.white
            }
            Text(drink.strDrink)
                .font(.title)
        }
    }
}

