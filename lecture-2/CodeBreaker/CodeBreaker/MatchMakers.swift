//
//  MatchMakers.swift
//  CodeBreaker
//
//  Created by Nick Voloshyn on 09.09.2026.
//

import SwiftUI


enum Match {
    case nomatch, exact, inexact
}


struct MatchMakers: View {
    
    var matches: [Match]
    
    var body: some View {
        HStack {
            VStack {
                matchMaker(peg: 0)
                matchMaker(peg: 1)
            }
            VStack {
                matchMaker(peg: 2)
                matchMaker(peg: 3)
            }
        }
    }
    
    
    func matchMaker(peg: Int) -> some View {
        let exactCount: Int = matches.count(where: { m in m == .exact })
//        or you can write closure in short manner like below:
        let foundCount: Int = matches.count { $0 != .nomatch }
        return Circle()
            .fill(exactCount > peg ? .primary : Color.clear)
            .strokeBorder(foundCount > peg ? .primary : Color.clear, lineWidth: 2.0)
            .aspectRatio(1/1, contentMode: .fit)
    }
    
    
}

#Preview {
    MatchMakers(matches: [.exact, .inexact, .nomatch])
}
