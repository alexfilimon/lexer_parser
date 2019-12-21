//
//  TokenizerConstants.swift
//  MK_lab3_tree
//
//  Created by Alexander Filimonov on 21/12/2019.
//  Copyright © 2019 Alexander Filimonov. All rights reserved.
//

enum TokenizerConstants {

    static let matrix: [[Int]] = [
        [-1, -1, -1, -1, -1, -1, -1, -1, -1, -1],
        [ 2, -1, -1, -1, -1, -1, -1, -1, -1,  0],
        [-1,  3, -1, -1, -1, -1, -1, -1, -1, -1],
        [-1, -1,  4, -1, -1, -1, -1, -1, -1, -1],
        [ 7, -1, -1, 10, -1, -1,  5, -1, -1, -1],
        [ 6, -1, -1,  8, -1, -1, -1, -1, -1, -1],
        [-1, -1, -1, -1, -1,  5, -1,  7, -1, -1],
        [-1, -1, -1, -1, -1,  4, -1, -1,  1, -1],
        [-1, -1, -1, -1,  9, -1, -1, -1, -1, -1],
        [-1, -1, -1,  6, -1, -1, -1, -1, -1, -1],
        [-1, -1, -1, -1, 11, -1, -1, -1, -1, -1],
        [-1, -1, -1,  7, -1, -1, -1, -1, -1, -1]
    ]

    static func getSymbolPositionInMatrix(symbol: Character) -> Int? {
        switch symbol {
            case "a", "b", "c":
                return 0
            case ":":
                return 1
            case "=":
                return 2
            case "'":
                return 3
            case "d"..."z":
                return 4
            case "+", "/", "-", "*":
                return 5
            case "(":
                return 6
            case ")":
                return 7
            case ";":
                return 8
            case "$":
                return 9
            default:
                return nil
        }
    }

}
