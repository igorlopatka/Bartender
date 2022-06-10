//
//  ContentView.swift
//  Bartender
//
//  Created by Igor Łopatka on 10/06/2022.
//

import SwiftUI

struct ContentView: View {
    
    @State private var loadingState = LoadingState.loading
    
    enum LoadingState {
        case loading, loaded, failed
    }
    
    var body: some View {
        NavigationView {
            Section {
                switch loadingState {
                case .loading:
                    List {
                        
                    }
                case .loaded:
                    ProgressView()
                case .failed:
                    Text("No drinks available")
                }
            }
            .navigationTitle("Bartender")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
