//
//  Sequence+Extension.swift
//  SwiftConcurrency
//
//  Created by Mendez, Juan on 4/25/25.
//


import Foundation

extension Sequence {
    func forEachAsyncInSequence(
        _ operation: @escaping (Element) async throws -> Void
    ) async rethrows {
        for element in self {
            try? await operation(element)
        }
    }

    func forEachAsyncInParallel(
        _ operation: @escaping (Element) async throws -> Void
    ) async rethrows {
        
        await withTaskGroup { group in
            for element in self {
                group.addTask {
                    try? await operation(element)
                }
            }
        }
    }
}
