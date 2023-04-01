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
            TabAView()
                .tabItem {
                    Image(systemName: "square.and.arrow.up")
                    Text("PokopokeList")
                }
            TabBView()
                .tabItem {
                    Image(systemName: "pencil.circle")
                    Text("Nanmonai")
                }
        }
    }
}

struct TabAView: View {
    @StateObject var pokeData = PokeRequest()
    var body: some View {
            NavigationView {
                List(pokeData.pokemonList) { pokemon in
                    HStack {
                        
                        AsyncImage(url: URL(string: pokemon.sprites.frontImage)) { image in
                            image
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(height: 40)
                        } placeholder: {
                            ProgressView()
                        }
                        Text(pokemon.name)
                        NavigationLink(destination: Text(pokemon.name)) {
                            
                        }
                    }
                    //                    .onTapGesture {
                    //                        print("\(pokemon.name)がタップされたよ")
                    //                    }
                }.navigationBarTitle("一覧")
            }.onAppear {
                Task {
                    await pokeData.fetchPokemonData()
                }
        }
    }
}

struct TabBView: View {
    var body: some View {
        Text("TabB")
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
