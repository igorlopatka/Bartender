//
//  SearchFor.swift
//  Bartender
//
//  Created by Igor Łopatka on 17/11/2022.
//

import Foundation

enum SearchFor: Int, CustomStringConvertible {
    case name, ingredient
    
    static func allValues() -> [String] {
        return [name, ingredient].map({$0.description})
    }
    
    static func count() -> Int {
        return allValues().count
    }
    
    public var description: String {
        switch self {
        case .name:
            return "Name"
        case .ingredient:
            return "Ingredient"
        }
    }
}
