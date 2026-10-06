//
//  PegChooser.swift
//  CodeBreaker
//
//  Created by Nick Voloshyn on 06.10.2026.
//

import SwiftUI

struct PegChooser: View {
    let choices: [Peg]
    let onChoose: ((Peg) -> Void)?
    
    var body: some View {
        HStack {
            ForEach(choices, id: \.self) { peg in
                Button {
                    onChoose?(peg)
                } label: {
                    PegView(peg: peg)
                }
            }
        }
    }
}

//#Preview {
//    PegChooser()
//}
