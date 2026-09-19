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
    @State var game = CodeBreaker(pegChoices: [.brown, .yellow, .orange, .black])
    
    var body: some View {
        VStack {
            view(for: game.masterCode)
            ScrollView {
                view(for: game.guess)
                ForEach(game.attempts.indices.reversed(), id: \.self) { index in
                    view(for: game.attempts[index])
                }
            }
        }
        .padding()
    }
    
    
    var guessButton: some View {
        Button("Guess") {
            withAnimation {
                game.attemptGuess()
            }
        }
        .font(.system(size: 80.0))
        .minimumScaleFactor(0.1)
    }

    func view(for code: Code) -> some View {
        HStack {
            ForEach(code.pegs.indices, id: \.self) { i in
                RoundedRectangle(cornerRadius: 10.0)
                    .overlay(content: {
                        if code.pegs[i] == Code.missing {
                            RoundedRectangle(cornerRadius: 10.0)
                                .strokeBorder(Color.gray)
                        }
                    })
                    .contentShape(Rectangle())
                    .aspectRatio(1/1, contentMode: .fit)
                    .foregroundStyle(code.pegs[i])
                    .onTapGesture {
                        if code.kind == .guess {
                            game.changeGuessPeg(at: i)
                        }
                    }
            }
//            `.overlay` modifier allows add some content not using ZStack
            MatchMakers(matches: code.matches)
                .overlay {
                    if code.kind == .guess {
                        guessButton
                    }
                }
        }
    }
}


#Preview {
    CodeBreakerView()
}
