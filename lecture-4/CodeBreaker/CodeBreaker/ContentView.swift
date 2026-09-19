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

    
    func pegs(colors: [Color]) -> some View {
        HStack {
            ForEach(colors.indices, id: \.self) { i in
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
