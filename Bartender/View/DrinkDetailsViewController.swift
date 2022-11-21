//
//  DrinkDetailsViewController.swift
//  Bartender
//
//  Created by Igor Łopatka on 18/11/2022.
//

import UIKit

class DrinkDetailsViewController: UIViewController {
    
    var drinkID = ""
    var drinkTitle = ""
    var drinkWithDetails: Drink?
    
    override func viewDidLoad() {
        self.title = drinkTitle
        self.view.backgroundColor = .white
        DispatchQueue.main.async {
            self.fetchDrinkDetails(id: self.drinkID)
        }
    }
    
    func fetchDrinkDetails(id: String)  {
                
        let urlString = "https://www.thecocktaildb.com/api/json/v1/1/lookup.php?i=\(id)"
        
        let url = URL(string: urlString)!
        let session = URLSession.shared
        let request = URLRequest(url: url)
        let task = session.dataTask(with: request as URLRequest, completionHandler: { [self] data, response, error in
            guard error == nil else {
                return
            }
            guard let data = data else {
                return
            }
            do {
                let decoder = JSONDecoder()
                let response = try decoder.decode(Drinks.self, from: data)
                drinkWithDetails = response.drinks[0]
            } catch {
                print(error)
            }
        })
        task.resume()
    }
}
