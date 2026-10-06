//
//  Code.swift
//  CodeBreaker
//
//  Created by Nick Voloshyn on 06.10.2026.
//


import SwiftUI


extension Peg {    
    static let missing = Color.clear
}



struct Code {
    var kind: Kind
    var pegs: [Peg] = Array(repeating: Peg.missing, count: 4)
    
    static let missingPeg: Peg = .clear
    
//    Here Equatable is necessary because `attempt` has associated data
//    `Match` is also `Equatable` so there is no need to write
//    static func ==(lhs:...
//    Otherwise this func wolud be necessary
    enum Kind: Equatable {
        case master(isHidden: Bool),
             guess,
             attempt([Match]),
             unknown
    }
    
    mutating func randomize(from pegChoices: [Peg]) {
        for i in pegs.indices {
            pegs[i] = pegChoices.randomElement() ?? Code.missingPeg
        }
    }
    
    
    var isHidden: Bool {
        switch kind {
        case .master(let isHidden):
            return isHidden
        default:
            return false
        }
    }
    
    
    mutating func reset() {
        pegs = Array(repeating: Code.missingPeg, count: 4)
    }
    
    
    var matches: [Match]? {
        switch kind {
        case .attempt(let matches):
            return matches
        default:
            return nil
        }
    }
    
    func match(against otherCode: Code) -> [Match] {
        var pegsToMach = otherCode.pegs
        
        let backwardExactMatches = pegs.indices.reversed().map { i in
            if pegsToMach.count > i, pegsToMach[i] == pegs[i] {
                pegsToMach.remove(at: i)
                return Match.exact
            }
            return .nomatch
        }
        
        let exactMatches = Array(backwardExactMatches.reversed())
        
        return pegs.indices.map { i in
            if exactMatches[i] != .exact, let matchIndex = pegsToMach.firstIndex(of: pegs[i]) {
                pegsToMach.remove(at: matchIndex)
                return .inexact
            }
            return exactMatches[i]
        }
        
    }
}
