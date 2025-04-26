//
//  Extensions.swift
//  SwiftConcurrency
//
//  Created by Mendez, Juan on 4/16/25.
//

import Foundation

extension String {
    var isNotEmpty: Bool  {
        isEmpty == false
    }

    var isBlank : Bool {
        isEmpty == true || trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
    }

    var isNotBlank : Bool {
        !isBlank
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
