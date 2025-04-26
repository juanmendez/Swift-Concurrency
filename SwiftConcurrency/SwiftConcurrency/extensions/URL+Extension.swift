//
//  URL+Extension.swift
//  SwiftConcurrency
//
//  Created by Mendez, Juan on 4/25/25.
//

import Foundation

extension URL {
    func fetchData() async -> Data? {
        try? await URLSession.shared.data(from: self).0
    }

    func fetchDataDeferred() async -> Data? {
        await withCheckedContinuation { continuation in
            URLSession.shared.dataTask(with: self) { data, response, error in
                continuation.resume(returning: data)
            }.resume()
        }
    }
}
