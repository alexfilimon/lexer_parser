//
//  Parser.swift
//  MK_lab3_tree
//
//  Created by Alexander Filimonov on 21/12/2019.
//  Copyright © 2019 Alexander Filimonov. All rights reserved.
//

class Parser {
    let parserTable: [String: [Int]]
    let tokensIterator: TokensIterator
    let rules: [String]
    let ruleDelimeter: String
    let tokenPositionInMatrix: (Token) -> Int?
    private(set) var tree: Node = Node()

    init(
        parserTable: [String: [Int]],
        tokensIterator: TokensIterator,
        rules: [String],
        ruleDelimeter: String,
        tokenPositionInMatrix: @escaping (Token) -> Int?
    ) {
        self.parserTable = parserTable
        self.tokensIterator = tokensIterator
        self.rules = rules
        self.ruleDelimeter = ruleDelimeter
        self.tokenPositionInMatrix = tokenPositionInMatrix
    }

    func parse() -> Result<Node, ParserError> {
        tree = Node(rule: "S")
        tokensIterator.clear()

        do {
            try handleToken(currentNode: tree, temp: ["S"])
        } catch {
            return .failure((error as? ParserError) ?? .errorInProgram)
        }

        return .success(tree)
    }

    /// Итерация разбора
    /// - Parameters:
    ///   - token: текущий токен для разбора
    ///   - currentNode: Текущий указатель на дерево
    ///   - temp: Магазин
    func handleToken(currentNode: Node, temp: [String]) throws {
        guard let token = tokensIterator.readCurrent(), !temp.isEmpty else {
            return
        }

        // body
        guard let topTemp = temp.first else {
            throw ParserError.noSymbolsInTemp
        }
        if topTemp.starts(with: "<") {
            // Токен
            if token.asStringWithoutPayload() == topTemp {
                // Если элемент в магазине и текущий токен совпадают => удаляем из магазина токен
                var newTemp = temp
                newTemp.removeFirst()

                tokensIterator.moveNext()
                let newNode = Node(token: token)
                currentNode.parent?.replaceChild(currentNode, with: newNode)
                try handleToken(currentNode: newNode, temp: newTemp)
            } else {
                throw ParserError.topTempAndTokenAreNotEqual(topTemp: topTemp, token: token)
            }
        } else {
            // Не токен
            if
                let tokenPositionInTable = tokenPositionInMatrix(token),
                let nextRuleIndex = parserTable[topTemp]?[tokenPositionInTable]
            {
                if nextRuleIndex == -1 {
                    throw ParserError.unexpectedToken(token: token)
                }
                // Получили следующее правило
                let ruleParts = getRuleParts(at: nextRuleIndex - 1)

                for part in ruleParts {
                    let node = Node(rule: part)
                    currentNode.addChild(node)

                    try handleToken(currentNode: node, temp: [part])
                }
            } else {
                throw ParserError.errorInProgram
            }
        }
    }

    func getRule(at index: Int) -> String {
        return rules[index].components(separatedBy: ruleDelimeter)[1]
    }

    func getRuleParts(at index: Int) -> [String] {
        var parts: [String] = []
        var rule = getRule(at: index)
        while !rule.isEmpty {
            guard let part = getFirstElement(from: rule) else {
                continue
            }
            parts.append(part)
            rule.removeFirst(part.count)
        }
        return parts
    }

    func getFirstElement(from temp: String) -> String? {
        if temp.starts(with: "<") {
            guard let closeTokenIndex = temp.firstIndex(of: ">") else {
                return nil
            }
            return String(temp.prefix(through: closeTokenIndex))
        } else {
            guard let first = temp.first else {
                return nil
            }
            return String(first)
        }
    }
}
