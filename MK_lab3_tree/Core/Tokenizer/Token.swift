//
//  Token.swift
//  MK_lab3_tree
//
//  Created by Alexander Filimonov on 21/12/2019.
//  Copyright © 2019 Alexander Filimonov. All rights reserved.
//

enum Token: TokenAbstract {
    case id(String)
    case assignment
    case operation(Operation)
    case openBracket
    case closeBracket
    case quote
    case letter(Character)
    case semicolon
    case endOfLine

    func asStringWithPayload() -> String {
        switch self {
            case .id(let id):
                return "<id: \(id)>"
            case .assignment:
                return "<:=>"
            case .operation(let operation):
                return "<operation: \(operation.rawValue)>"
            case .openBracket:
                return "<(>"
            case .closeBracket:
                return "<)>"
            case .quote:
                return "<'>"
            case .letter(let letter):
                return "<symbol: \(letter)>"
            case .semicolon:
                return "<;>"
            case .endOfLine:
                return "<$>"
        }
    }

    func asStringWithoutPayload() -> String {
        switch self {
            case .id:
                return "<id>"
            case .assignment:
                return "<:=>"
            case .operation:
                return "<operation>"
            case .openBracket:
                return "<(>"
            case .closeBracket:
                return "<)>"
            case .quote:
                return "<'>"
            case .letter:
                return "<symbol>"
            case .semicolon:
                return "<;>"
            case .endOfLine:
                return "<$>"
        }
    }

    static func get(fromState: Int, toState: Int, payload: String) -> Token? {
        switch (fromState, toState) {
            case (6, 7):
                return .closeBracket
            case (1, 2), (5, 6), (4, 7):
                return .id(payload)
            case (9, 6), (11, 7), (4, 10), (5, 8):
                return .quote
            case (7, 4), (6, 5):
                guard let operation = Operation(raw: payload) else {
                    return nil
                }
                return .operation(operation)
            case (3, 4):
                return .assignment
            case (4, 5):
                return .openBracket
            case (8, 9), (10, 11):
                guard let char = payload.first else {
                    return nil
                }
                return .letter(char)
            case (7, 1):
                return .semicolon
            case (_, 0):
                return .endOfLine
            default:
                return nil
        }
    }

    static func needGetToken(state: Int) -> Bool {
        switch state {
        case 3:
            return false
        default:
            return true
        }
    }
}
