//
//  TheCocktailsDBService.swift
//  Bartender
//
//  Created by Igor Łopatka on 25/11/2022.
//

import Foundation

protocol Servicing {
    func fetchFilteredList(type: String, search: String, completed: @escaping (Result<[Drink], Error>) -> Void)
    func fetchDrinkDetails(id: String, completed: @escaping (Result<Drink, Error>) -> Void)
}

class TheCocktailsDBService: Servicing {
    
    let baseURL = "https://www.thecocktaildb.com/api/json/v1/1/"
    
    func fetchFilteredList(type: String, search: String, completed: @escaping (Result<[Drink], Error>) -> Void)  {
        
        let endPoint = baseURL + "\(type).php?s=\(search)"
        let url = URL(string: endPoint)!
        let session = URLSession.shared
        let request = URLRequest(url: url)
        let task = session.dataTask(with: request as URLRequest, completionHandler: { data, response, error in
            guard error == nil else {
                return
            }
            guard let data = data else {
                return
            }
            do {
                let decoder = JSONDecoder()
                let response = try decoder.decode(Drinks.self, from: data)
                completed(.success(response.drinks))
            } catch {
                print(error)
            }
        })
        task.resume()
    }
    
    
    func fetchDrinkDetails(id: String, completed: @escaping (Result<Drink, Error>) -> Void) {
                
        let endPoint = baseURL + "lookup.php?i=\(id)"
        
        let url = URL(string: endPoint)!
        let session = URLSession.shared
        let request = URLRequest(url: url)
        let task = session.dataTask(with: request as URLRequest, completionHandler: { data, response, error in
            guard error == nil else {
                return
            }
            guard let data = data else {
                return
            }
            do {
                let decoder = JSONDecoder()
                let response = try decoder.decode(Drinks.self, from: data)
                let drinkWithDetails = response.drinks[0]
                completed(.success(drinkWithDetails))
            } catch {
                print(error)
            }
        })
        task.resume()
    }
}
