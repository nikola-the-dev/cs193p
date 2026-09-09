//
//  ContentView.swift
//  CodeBreaker
//
//  Created by Nick Voloshyn on 09.09.2026.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            pegs(colors: [.red, .green, .green, .yellow])
            pegs(colors: [.blue, .red, .green, .yellow])
            pegs(colors: [.green, .green, .green, .blue])
        }
        .padding()
    }
        
//    Then we can call this variable in component just like this:
//    VStack {
//        pegs
//        pegs
//        pegs
//    }
    var pegs: some View {
        HStack {
            Circle().foregroundStyle(.red)
//            foregroundStyle modifier is more powerfull than foregroundColor
            Circle().foregroundStyle(.red)
            Circle().foregroundStyle(.red)
            Circle().foregroundStyle(.green)
        }
    }
    
    
    func pegs(colors: [Color]) -> some View {
        HStack {
            ForEach(colors.indices, id: \.self) { i in
//                id field in this call needed mostly for animation because system need to know
//                which and how update every element, this field should be UNIQUE
//                \.self in this case means that this concret object responds as id
                RoundedRectangle(cornerRadius: 10.0)
                    .aspectRatio(1/1, contentMode: .fit)
                    .foregroundStyle(colors[i])
            }
            MatchMakers(matches: [.exact, .inexact, .nomatch, .exact])
        }
    }
}


#Preview {
    ContentView()
}
