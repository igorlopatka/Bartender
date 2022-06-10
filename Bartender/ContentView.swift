//
//  ContentView.swift
//  Bartender
//
//  Created by Igor Łopatka on 10/06/2022.
//

import SwiftUI

struct ContentView: View {
    
    @State private var loadingState = LoadingState.empty
    @State private var searchFor = SearchType.name
    @State private var searchText = ""
    
    enum LoadingState {
        case loading, loaded, failed, empty
    }
    
    enum SearchType {
        case name, ingredient
    }
    
    var searchType: String {
        switch searchFor {
        case .name:
            return "name"
        case .ingredient:
            return "ingredient"
        }
    }
    
    var body: some View {
        NavigationView {
            
            Section {
                Picker("Units: ", selection: $searchFor) {
                    Text("Name").tag(SearchType.name)
                    Text("Ingredient").tag(SearchType.ingredient)
                }
                .padding(10)
                .pickerStyle(SegmentedPickerStyle())
                Spacer()
                switch loadingState {
                case .loaded:
                    List {
                        
                    }
                case .loading:
                    ProgressView()
                case .failed:
                    Text("Failed to load drinks")
                case .empty:
                    Text("Use searchbar to find drinks")
                }
                Spacer()
            }
            .searchable(text: $searchText, prompt: "Search for \(searchType)")
            .navigationTitle("Bartender 🍸")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
