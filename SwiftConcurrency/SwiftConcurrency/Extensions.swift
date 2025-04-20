//
//  Extensions.swift
//  SwiftConcurrency
//
//  Created by Mendez, Juan on 4/16/25.
//

import Foundation

extension Data {
    func cache() async -> String? {
        let fileName = UUID().uuidString
        let urlStr = NSTemporaryDirectory() + fileName
        let url = URL(fileURLWithPath: urlStr)
        do {
            try self.write(to: url)
            return fileName
        } catch {
            return nil
        }
    }
}

extension URL {
    func fetchData() async -> Data? {
        try? await URLSession.shared.data(from: self).0
    }
}

extension Sequence {
    func forEachAsyncInParalell(
        _ operation: @escaping (Element) async throws -> Void
    ) async rethrows {
        for element in self {
            try? await operation(element)
        }
    }

    func forEachAsyncInSequence(
        _ operation: @escaping (Element) async throws -> Void
    ) async rethrows {
        await withTaskGroup() { group in
            for element in self {
                group.addTask {
                    try? await operation(element)
                }
            }
        }
    }
}

extension String {
    /// Checks if
    var isNotEmpty: Bool  {
        isEmpty == false
    }

    var isBlank : Bool {
        trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
    }

    var isNotBlank : Bool {
        isNotEmpty && !trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
    }
}

extension String? {
    var hasContent : Bool {
        if let self {
            self.isNotBlank
        } else {
            false
        }
    }
}
