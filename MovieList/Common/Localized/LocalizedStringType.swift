//
//  LocallizedStringType.swift
//  MovieList
//
//  Created by wyn on 2023/1/29.
//

import Foundation

protocol LocalizedStringType {}

extension LocalizedStringType {
    var prefix: String { return "\(type(of: self))" }
    var text: String { return NSLocalizedString(prefix + "." + String(describing: self), comment: "") }
}
