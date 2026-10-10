//
//  CodeBreakerView.swift
//  CodeBreaker
//
//  Created by Nick Voloshyn on 09.09.2026.
//

import SwiftUI

struct CodeBreakerView: View {
//    We marks this as var because it (CodeBreaker struct) has mutating func changeGuessPeg(at:)
//    But it conflicts because all calls than need to mark mutating
//    This why @State was added
//    @State it macros that keeps pointer on the class _game
    @State private var game = CodeBreaker(pegChoices: [.brown, .yellow, .orange, .black, .green])
    @State private var selection: Int = 0
    
    var body: some View {
        VStack {
//            Because we add init with def values we can to get rid of some extra declarations
            CodeView(code: game.masterCode)
            ScrollView {
                if !game.isOver {
                    CodeView(code: game.guess, selection: $selection) {
                        guessButton
                    }
                }
                ForEach(game.attempts.indices.reversed(), id: \.self) { index in
                    CodeView(code: game.attempts[index]) {
                        if let matches = game.attempts[index].matches {
                            MatchMakers(matches: matches)
                        }
                    }
                }
            }
            PegChooser(choices: game.pegChoices) { peg in
                game.setGuessPeg(peg, at: selection)
                selection = (selection + 1) % game.masterCode.pegs.count
            }
        }
        .padding()
    }
    
    
    var guessButton: some View {
        Button("Guess") {
            withAnimation {
                game.attemptGuess()
                selection = 0
            }
        }
        .font(.system(size: GuessButton.maximuFontSize))
        .minimumScaleFactor(GuessButton.scaleFactor)
    }

    
    
    struct GuessButton {
        static let minimuFontSize: CGFloat = 8.0
        static let maximuFontSize: CGFloat = 80.0
        static let scaleFactor: CGFloat = minimuFontSize / maximuFontSize
    }
    
    
    
    
}


extension Color {
    static func gray(_ brightness: CGFloat) -> Color {
        .init(hue: 140.0 / 360.0, saturation: 0.0, brightness: brightness)
    }
}


#Preview {
    CodeBreakerView()
}
