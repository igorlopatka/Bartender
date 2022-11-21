//
//  DrinkDetailsViewController.swift
//  Bartender
//
//  Created by Igor Łopatka on 18/11/2022.
//

import UIKit

class DrinkDetailsViewController: UIViewController {
    
    var drinkTitle = ""
    
    override func viewDidLoad() {
        self.title = drinkTitle
        self.view.backgroundColor = .white
    }
}
