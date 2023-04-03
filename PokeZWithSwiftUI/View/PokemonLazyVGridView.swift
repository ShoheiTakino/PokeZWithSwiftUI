//
//  PokemonLazyVGridView.swift
//  PokeZWithSwiftUI
//
//  Created by 滝野翔平 on 2023/04/03.
//

import SwiftUI

struct PokemonLazyVGridView: View {
    
    @StateObject var pokeData = PokeRequest()
    var pokemonList: [Pokemon] = []
    private var columns: [GridItem] = Array(repeating: .init(.flexible(),
                                                             spacing: 10,
                                                             alignment: .center),
                                            count: 2)
    //    private var columns = [GridItem(.flexible()), GridItem(.flexible())]
    let screenWidth = UIScreen.main.bounds.width
    var body: some View {
        NavigationView {
            ScrollView(.vertical) {
                LazyVGrid(columns: columns) {
                    ForEach((0..<pokeData.pokemonList.count), id: \.self) { index in
                        NavigationLink(destination: PokeDetailView(pokemon: pokeData.pokemonList[index])) {
                            AsyncImage(url: URL(string: pokeData.pokemonList[index].sprites.frontImage)) { image in
                                image
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(height: 200)
                            } placeholder: {
                                ProgressView()
                            }
                        }
                    }
                }
            }.navigationBarTitle("一覧(GridLayout)")
        }.onAppear {
            Task {
                await pokeData.fetchPokemonData()
            }
        }
    }
    mutating func getPokemon() async -> [Pokemon] {
        await pokemonList =  pokeData.fetchPokemonData()!
        return pokemonList
    }
}
