//
//  CodeBreaker.swift
//  CodeBreaker
//
//  Created by Nick Voloshyn on 19.09.2026.
//

import SwiftUI

// It's type pseudo and code below actually means that Peg is equal to Color
// But if I need to extended this struct/class in future I just add it and
// there is no need to rewrite bunch of codes
typealias Peg = Color


struct CodeBreaker {
    var masterCode: Code = Code(kind: .master)
    var guess: Code = Code(kind: .guess)
    var attempts: [Code] = [Code]()
    var pegChoices: [Peg]
    
    init(pegChoices: [Peg] = [.red, .green, .blue, .yellow]) {
        self.pegChoices = pegChoices
        masterCode.randomize(from: pegChoices)
        print(masterCode)
    }
    
    mutating func attemptGuess() {
        var attempt = guess
        attempt.kind = .attempt(guess.match(against: masterCode))
        attempts.append(attempt)
    }
    
    mutating func changeGuessPeg(at index: Int) {
        let existingPeg = guess.pegs[index]
        if let indexOfExistingPegInPegCoices = pegChoices.firstIndex(of: existingPeg) {
            let newPeg = pegChoices[(indexOfExistingPegInPegCoices + 1) % pegChoices.count]
            guess.pegs[index] = newPeg
        } else {
            guess.pegs[index] = pegChoices.first ?? Code.missingPeg
        }
    }
}


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
        case master,
             guess,
             attempt([Match]),
             unknown
    }
    
    mutating func randomize(from pegChoices: [Peg]) {
        for i in pegChoices.indices {
            pegs[i] = pegChoices.randomElement() ?? Code.missingPeg
        }
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
        
        var backwardExactMatches = pegs.indices.reversed().map { i in
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
