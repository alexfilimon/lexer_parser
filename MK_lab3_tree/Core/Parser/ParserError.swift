//
//  ParserError.swift
//  MK_lab3_tree
//
//  Created by Alexander Filimonov on 21/12/2019.
//  Copyright © 2019 Alexander Filimonov. All rights reserved.
//

enum ParserError: Error {
    case noSymbolsInTemp
    case errorInProgram
    case topTempAndTokenAreNotEqual(topTemp: String, token: Token)
    case unexpectedToken(token: Token)
}
