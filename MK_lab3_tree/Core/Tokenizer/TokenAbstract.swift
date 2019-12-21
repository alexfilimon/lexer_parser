//
//  TokenAbstract.swift
//  MK_lab3_tree
//
//  Created by Alexander Filimonov on 21/12/2019.
//  Copyright © 2019 Alexander Filimonov. All rights reserved.
//

protocol TokenAbstract {
    static func get(fromState: Int, toState: Int, payload: String) -> Self?
    static func needGetToken(state: Int) -> Bool
    func asStringWithoutPayload() -> String
    func asStringWithPayload() -> String
}
