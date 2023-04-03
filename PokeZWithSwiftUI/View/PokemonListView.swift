//
//  PokemonListView.swift
//  PokeZWithSwiftUI
//
//  Created by 滝野翔平 on 2023/04/03.
//

import SwiftUI

struct PokemonListView: View {
    
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
            }.navigationBarTitle("一覧(List)")
        }.onAppear {
            Task {
                await pokeData.fetchPokemonData()
            }
        }
    }
}
