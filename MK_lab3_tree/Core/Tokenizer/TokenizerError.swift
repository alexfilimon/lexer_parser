//
//  TokenizerError.swift
//  MK_lab3_tree
//
//  Created by Alexander Filimonov on 21/12/2019.
//  Copyright © 2019 Alexander Filimonov. All rights reserved.
//

enum TokenizerError: Error {
    case badSymbol(symbol: Character)
    case goodSymbolOnWrongPosition(symbol: Character)
    case badEndState(currentState: Int)
}
