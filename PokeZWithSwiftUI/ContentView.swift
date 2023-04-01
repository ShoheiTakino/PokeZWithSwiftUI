//
//  ContentView.swift
//  PokeZWithSwiftUI
//
//  Created by 滝野翔平 on 2023/04/01.
//

import SwiftUI

struct ContentView: View {
    @StateObject var pokeData = PokeRequest()
    var body: some View {
        VStack {
            Button("テキスト") {
                // ボタンがタップされたときのアクション
                Task {
                    await pokeData.fetchPokemonData()
                }
            }
            .padding()
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
                }
            }
        }
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
