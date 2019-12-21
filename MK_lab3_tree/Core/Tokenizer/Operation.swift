//
//  Operation.swift
//  MK_lab3_tree
//
//  Created by Alexander Filimonov on 21/12/2019.
//  Copyright © 2019 Alexander Filimonov. All rights reserved.
//

enum Operation: String {
    case add = "+"
    case sub = "-"
    case mul = "*"
    case div = "/"

    init?(raw: String) {
        guard let raw = Operation(rawValue: raw) else {
            return nil
        }
        self = raw
    }
}
