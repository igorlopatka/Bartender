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
        Text(drink.strDrink)
    }
}

//struct DrinkDetailView_Previews: PreviewProvider {
//    static var previews: some View {
//        DrinkDetailView(drink: <#Drink#>)
//    }
//}
