//
//  DrinkDetailsViewController.swift
//  Bartender
//
//  Created by Igor Łopatka on 18/11/2022.
//

import Combine
import UIKit

class DrinkDetailsViewController: UIViewController {
    
    var drinkID = ""
    var drinkTitle = ""
    var drinkWithDetails: Drink?
    
    override func viewDidLoad() {
        self.title = drinkTitle
        self.view.backgroundColor = .white
        self.fetchDrinkDetails(id: self.drinkID)
    }
    

}
