//
//  ContentView.swift
//  Bartender
//
//  Created by Igor Łopatka on 10/06/2022.
//

import SwiftUI

struct ContentView: View {
    
    @State private var drinks = [Drink]()
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
                        ForEach(drinks, id: \.self) { drink in
                            NavigationLink {
                                DrinkDetailView(drink: drink)
                            } label: {
                                HStack {
                                    AsyncImage(url: URL(string: drink.strDrinkThumb)) { image in
                                        image.resizable()
                                    } placeholder: {
                                        ProgressView()
                                    }
                                    .frame(width: 50, height: 50)
                                    .clipShape(RoundedRectangle(cornerRadius: 25))
                                    Text(drink.strDrink)
                                        .font(.title)
                                        .lineLimit(1)
                                }
                            }
                        }
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
        .onChange(of: searchText) { newValue in
            Task {
                await fetchDrinkList(search: newValue)
            }
        }
        .onChange(of: searchFor) { _ in
            Task {
                await fetchDrinkList(search: searchText)
            }
        }
    }

    func fetchDrinkList(search: String) async {
        
        let urlString: String
        
        switch searchFor {
        case .name:
            urlString = "https://www.thecocktaildb.com/api/json/v1/1/search.php?s=\(search)"
        case .ingredient:
            urlString = "https://www.thecocktaildb.com/api/json/v1/1/filter.php?i=\(search)"
        }
        
        guard let url = URL(string: urlString) else {
            print("Bad URL: \(urlString)")
            return
        }
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            let items = try JSONDecoder().decode(Drinks.self, from: data)
            drinks = items.drinks
            loadingState = .loaded
        } catch {
            loadingState = .failed
            print("Error fetching drinks: \(error)")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
