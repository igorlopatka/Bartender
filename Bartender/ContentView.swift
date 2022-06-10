//
//  ContentView.swift
//  Bartender
//
//  Created by Igor Łopatka on 10/06/2022.
//

import SwiftUI

struct ContentView: View {
    
    @State private var loadingState = LoadingState.loading
    @State private var searchFor = SearchType.name
    @State private var searchText = ""
    
    enum LoadingState {
        case loading, loaded, failed
    }
    
    enum SearchType {
        case name, ingredient
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
                
                switch loadingState {
                case .loading:
                    List {
                        
                    }
                case .loaded:
                    ProgressView()
                case .failed:
                    Text("Use search")
                }
            }
            .searchable(text: $searchText, prompt: "Search for ingredient")
            .navigationTitle("Bartender 🍸")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
