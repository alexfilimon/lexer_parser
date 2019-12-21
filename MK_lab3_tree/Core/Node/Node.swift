//
//  Node.swift
//  MK_lab3_tree
//
//  Created by Alexander Filimonov on 21/12/2019.
//  Copyright © 2019 Alexander Filimonov. All rights reserved.
//

class Node: CustomStringConvertible {

    // MARK: - Properties

    let token: Token?
    let rule: String?
    var children: [Node] = []
    var parent: Node?

    var description: String {
        return "\(token?.asStringWithPayload() ?? rule ?? "<root>")"
    }

    // MARK: - Initialization

    init(token: Token? = nil, rule: String? = nil) {
        self.token = token
        self.rule = rule
    }

    // MARK: - Internal methods

    func addChild(_ node: Node) {
        node.parent = self
        children.append(node)
    }

    func addChildren(_ nodes: [Node]) {
        nodes.forEach { addChild($0) }
    }

    func prettyPrint() {
        print(getString())
    }

    func printOnlyLast() {
        print(getStringLast())
    }

    func replaceChild(_ old: Node, with new: Node) {
        guard let parentChildIndex = children.firstIndex(where: { $0 === old }) else {
            return
        }
        children.remove(at: parentChildIndex)
        children.insert(new, at: parentChildIndex)
        old.parent = nil
        new.parent = self
    }

    // MARK: - Private methods

    private func getString(prefix: String = "", childPrefix: String = "") -> String {
        var buffer = "\n" + prefix + description

        for child in children {
            let isLast = children.firstIndex(where: { $0 === child }) == (children.count - 1)
            if isLast {
                buffer += child.getString(prefix: childPrefix + "└── ", childPrefix: childPrefix + "    ")
            } else {
                buffer += child.getString(prefix: childPrefix + "├── ", childPrefix: childPrefix + "│   ")
            }
        }

        return buffer
    }

    private func getStringLast() -> String {
        if children.isEmpty {
            return description
        }

        var resultString = ""

        for child in children {
            resultString += child.getStringLast()
        }

        return resultString
    }

}
