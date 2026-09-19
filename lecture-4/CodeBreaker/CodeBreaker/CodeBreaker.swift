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
            guess.pegs[index] = pegChoices.first ?? Code.missing
        }
    }
}


struct Code {
    var kind: Kind
    var pegs: [Peg] = Array(repeating: Code.missing, count: 4)
    
    static let missing: Peg = .clear
    
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
            pegs[i] = pegChoices.randomElement() ?? Code.missing
        }
    }
    
    var matches: [Match] {
        switch kind {
        case .attempt(let matches):
            return matches
        default:
            return []
        }
    }
    
    func match(against otherCode: Code) -> [Match] {
        var result: [Match] = Array(repeating: .nomatch, count: pegs.count)
        var pegsToMach = otherCode.pegs
        for i in pegs.indices.reversed() {
            if pegsToMach.count > i, pegsToMach[i] == pegs[i] {
                result[i] = .exact
                pegsToMach.remove(at: i)
            }
        }
        for i in pegs.indices {
            if result[i] != .exact {
                if let matchIndex = pegsToMach.firstIndex(of: pegs[i]) {
                    result[i] = .inexact
                    pegsToMach.remove(at: matchIndex)
                }
            }
        }
        return result
    }
}
