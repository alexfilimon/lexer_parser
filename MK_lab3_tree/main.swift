//
//  main.swift
//  MK_lab3_tree
//
//  Created by Alexander Filimonov on 21/12/2019.
//  Copyright © 2019 Alexander Filimonov. All rights reserved.
//

import Foundation

// --------------------------------------------------------
// -------------------- Lexer -----------------------------
// --------------------------------------------------------

// Входные строки
// a:=(c+b)+'e'+(a);b:='k';$
// a:=(b+c)/'f';b:=c;$
// a:=('f'+b);$
let tokenizer = Tokenizer<Token>(inputString: "a:=('f'+b);c:='k';$",
                                 tokenizerMatrix: TokenizerConstants.matrix,
                                 symbolPosition: TokenizerConstants.getSymbolPositionInMatrix)

var optionalTokens: [Token]?
switch tokenizer.tokenize() {
    case .success(let tokens):
        optionalTokens = tokens
        let tokensString = tokens.map({ $0.asStringWithPayload() }).joined()
        print("success: \(tokensString)")
    case .failure(let error):
        print("error: \(error)")
}
guard let tokens = optionalTokens else {
    fatalError("No tokens")
}

// --------------------------------------------------------
// -------------------- Parser ----------------------------
// --------------------------------------------------------

let parser = Parser(parserTable: ParserConstants.table,
                    tokensIterator: TokensIterator(tokens: tokens),
                    rules: ParserConstants.rules,
                    ruleDelimeter: ParserConstants.ruleDelimeter,
                    tokenPositionInMatrix: ParserConstants.getTokenPositionInMatrix)
switch parser.parse() {
case .success(let tree):
    tree.prettyPrint()
    tree.printOnlyLast()
case .failure(let error):
    print("error: \(error)")
}
