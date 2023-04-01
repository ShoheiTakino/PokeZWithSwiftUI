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
                        NavigationLink(destination: PokeDetailView(pokemon: pokemon)) {
                            
                        }
                    }
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

struct PokeDetailView: View {
    let pokemon: Pokemon
    var body: some View {
        Text("No. \(pokemon.id)")
            .font(.title)
            .fontWeight(.semibold)
        AsyncImage(url: URL(string: pokemon.sprites.frontImage)) { image in
            image
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(height: 200)
        } placeholder: {
            ProgressView()
        }
        Text(pokemon.name)
            .font(.body)
            .fontWeight(.bold)
        Text("\(pokemon.types[0].type.name)タイプ")
            .font(.body)
            .fontWeight(.bold)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
