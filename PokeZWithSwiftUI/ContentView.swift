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
                    Text("PokopokeCulom")
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
            }.navigationBarTitle("一覧(List)")
        }.onAppear {
            Task {
                await pokeData.fetchPokemonData()
            }
        }
    }
}


struct TabBView: View {
    @StateObject var pokeData = PokeRequest()
    var pokemonList: [Pokemon] = []
    private var columns: [GridItem] = Array(repeating: .init(.flexible(),
                                                             spacing: 10,
                                                             alignment: .center),
                                            count: 2)
    //    private var columns = [GridItem(.flexible()), GridItem(.flexible())]
    let screenWidth = UIScreen.main.bounds.width
    //    var body: some View {
    //        List(pokeData.pokemonList) { pokemon in
    //            HStack {
    //                ForEach(1..<2) { _ in
    //                    AsyncImage(url: URL(string: pokemon.sprites.frontImage)) { image in
    //                        image
    //                            .resizable()
    //                            .aspectRatio(contentMode: .fit)
    //                            .frame(height: 40)
    //                    } placeholder: {
    //                        ProgressView()
    //                    }
    //                    Text(pokemon.name)
    //                    NavigationLink(destination: PokeDetailView(pokemon: pokemon)) {
    //
    //                    }
    //                }
    //            }
    //        }.onAppear {
    //            Task {
    //                await pokeData.fetchPokemonData()
    //            }
    //        }
    //        .refreshable {
    //                    await pokeData.fetchPokemonData()
    //                }
    //    }
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
