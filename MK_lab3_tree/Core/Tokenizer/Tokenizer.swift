//
//  Tokenizer.swift
//  MK_lab3_tree
//
//  Created by Alexander Filimonov on 21/12/2019.
//  Copyright © 2019 Alexander Filimonov. All rights reserved.
//

class Tokenizer<Token: TokenAbstract> {
    let inputString: String
    let tokenizerMatrix: [[Int]]
    let symbolPosition: (Character) -> Int?

    init(inputString: String, tokenizerMatrix: [[Int]], symbolPosition: @escaping (Character) -> Int?) {
        self.inputString = inputString
        self.tokenizerMatrix = tokenizerMatrix
        self.symbolPosition = symbolPosition
    }

    func tokenize() -> Result<[Token], TokenizerError> {
        var currentState = 1
        var temp: String = ""
        var tokens: [Token] = []
        for char in inputString {
            guard let currentPosition = symbolPosition(char) else {
                return .failure(.badSymbol(symbol: char))
            }
            let nextState = tokenizerMatrix[currentState][currentPosition]
            if nextState == -1 {
                return .failure(.goodSymbolOnWrongPosition(symbol: char))
            }
            temp += String(char)
            if
                Token.needGetToken(state: nextState),
                let token = Token.get(fromState: currentState, toState: nextState, payload: temp)
            {
                tokens.append(token)
                temp = ""
            }
            currentState = nextState
        }
        return currentState == 0 ? .success(tokens) : .failure(.badEndState(currentState: currentState))
    }
}

