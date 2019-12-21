//
//  TokensIterator.swift
//  MK_lab3_tree
//
//  Created by Alexander Filimonov on 21/12/2019.
//  Copyright © 2019 Alexander Filimonov. All rights reserved.
//

final class TokensIterator {

    // MARK: - Properties

    let tokens: [Token]
    private(set) var currentIndex: Int

    // MARK: - Initialization

    init(tokens: [Token]) {
        self.tokens = tokens
        currentIndex = 0
    }

    // MARK: - Internal methods

    func moveNext() {
        currentIndex += 1
    }

    func readCurrent() -> Token? {
        if 0..<tokens.count ~= currentIndex {
            return tokens[currentIndex]
        }
        return nil
    }

    func clear() {
        currentIndex = 0
    }

}
