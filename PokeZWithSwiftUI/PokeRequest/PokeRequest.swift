//
//  PokeRequest.swift
//  PokeZWithSwiftUI
//
//  Created by 滝野翔平 on 2023/04/01.
//

import Foundation

final class PokeRequest: ObservableObject {
    
    func fetchPokemonData() async {
        guard let url = URL(string: "ttps://pokeapi.co/api/v2/ability/1/") else { return }
        print(#function, url)
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            let decoder = JSONDecoder()
            let json = try decoder.decode(Pokemon.self, from: data)
            print(#function, json)
        } catch {
            print(#function, "エラー")
        }
    }
}
