//
//  Extensions.swift
//  SwiftConcurrency
//
//  Created by Mendez, Juan on 4/16/25.
//

import Foundation

extension Data {
    func cache() -> String? {
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
    func fetchData() -> Data? {
        try? Data(contentsOf: self)
    }
}
