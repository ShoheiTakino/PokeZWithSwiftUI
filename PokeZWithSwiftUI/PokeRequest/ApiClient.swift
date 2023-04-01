//
//  ApiClient.swift
//  PokeZWithSwiftUI
//
//  Created by 滝野翔平 on 2023/04/01.
//

import Foundation

struct ApiClient {

    static func fetchData<T: Decodable>(urls: [URL]) async throws -> [T] {
        var results = [T]()

        try await withThrowingTaskGroup(of: (Data, URLResponse).self) { group in
            for url in urls {
                group.addTask(priority: nil) {
                    try await URLSession.shared.data(from: url)
                }
            }
            for try await (data, _) in group {
                let result = try JSONDecoder().decode(T.self, from: data)
                results.append(result)
            }
        }
        return results
    }
}
