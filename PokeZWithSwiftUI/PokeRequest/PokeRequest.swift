//
//  PokeRequest.swift
//  PokeZWithSwiftUI
//
//  Created by 滝野翔平 on 2023/04/01.
//

import Foundation

enum ApiRequestError: Error {
    case ConnectionError
    case ServerError
}

final class PokeRequest: ObservableObject {
    
    @Published var pokemonList: [Pokemon] = []
    
    func fetchPokemonData() async -> [Pokemon]? {
        print(#function, 1)
        let id = 200
        var urlList: [URL] = []
        for i in 1..<id {
            guard let url = URL(string: "https://pokeapi.co/api/v2/pokemon/\(i)/") else { return nil }
            urlList.append(url)
        }
        
        print(#function, urlList)
        do {
            for i in 0..<urlList.count {
                let (data, _) = try await URLSession.shared.data(from: urlList[i])
                let decoder = JSONDecoder()
                let json = try decoder.decode(Pokemon.self, from: data)
                print(#function, json)
                pokemonList.append(json)
            }
            return pokemonList
//            for i in 1..<id {
//                let (data, _) = try await URLSession.shared.data(from: urlList[i])
//                let decoder = JSONDecoder()
//                let json = try decoder.decode(Pokemon.self, from: data)
//                print(#function, json)
//            }
        } catch {
            print(#function, "エラー")
        }
        return nil
    }
}
