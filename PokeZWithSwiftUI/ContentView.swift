//
//  ContentView.swift
//  PokeZWithSwiftUI
//
//  Created by 滝野翔平 on 2023/04/01.
//

import SwiftUI

struct ContentView: View {
    
    var body: some View {
        
        TabView {
            PokemonListView()
                .tabItem {
                    Image(systemName: "rectangle.grid.1x2")
                    Text("List")
                }
            PokemonLazyVGridView()
                .tabItem {
                    Image(systemName: "square.grid.2x2")
                    Text("LazyGrid")
                }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
