//
//  ParserConstants.swift
//  MK_lab3_tree
//
//  Created by Alexander Filimonov on 21/12/2019.
//  Copyright © 2019 Alexander Filimonov. All rights reserved.
//

enum ParserConstants {

    static let table: [String: [Int]] = [
        "A": [12, -1, -1, 12, -1, -1, -1, -1, -1],
        "C": [-1, -1, -1, -1, -1, 16, -1, -1, -1],
        "D": [-1, -1, -1, -1, 11, -1, -1, -1, -1],
        "E": [-1, -1, -1, -1, -1, -1, -1,  3, -1],
        "F": [17, -1, -1, 17, -1, -1, -1, -1, -1],
        "G": [ 7, -1, -1,  8, -1, -1, -1, -1, -1],
        "H": [-1, 19, -1, -1, -1, -1, 18, -1, -1],
        "I": [ 9, -1, -1, -1, -1, -1, -1, -1, -1],
        "K": [ 5, -1, -1,  5, -1,  6, -1, -1, -1],
        "L": [-1, 13, -1, -1, -1, -1, -1, 14, -1],
        "M": [-1, -1,  4, -1, -1, -1, -1, -1, -1],
        "O": [-1, 15, -1, -1, -1, -1, -1, -1, -1],
        "Q": [-1, -1, -1, 10, -1, -1, -1, -1, -1],
        "S": [ 1, -1, -1, -1, -1, -1, -1, -1,  2]
    ]
    static let ruleDelimeter = " -> "
    static let rules: [String] = [
        "S -> IMK",
        "S -> <$>",
        "E -> <;>S",
        "M -> <:=>",
        "K -> A",
        "K -> C",
        "G -> I",
        "G -> Q",
        "I -> <id>",
        "Q -> <'>D<'>",
        "D -> <symbol>",
        "A -> GL",
        "L -> OK",
        "L -> E",
        "O -> <operation>",
        "C -> <(>FL",
        "F -> GH",
        "H -> <)>",
        "H -> OF"
    ]

    static func getTokenPositionInMatrix(token: Token) -> Int? {
        switch token {
            case .id:
                return 0
            case .operation:
                return 1
            case .assignment:
                return 2
            case .quote:
                return 3
            case .letter:
                return 4
            case .openBracket:
                return 5
            case .closeBracket:
                return 6
            case .semicolon:
                return 7
            case .endOfLine:
                return 8
        }
    }

}
