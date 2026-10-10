//
//  PegView.swift
//  CodeBreaker
//
//  Created by Nick Voloshyn on 06.10.2026.
//

import SwiftUI

struct PegView: View {
    
    let peg: Peg
    
    let pegShape = Circle()// RoundedRectangle(cornerRadius: 10.0)
    
    var body: some View {
        pegShape
            .contentShape(pegShape)
            .aspectRatio(1/1, contentMode: .fit)
            .foregroundStyle(peg)
    }
}

#Preview {
    PegView(peg: .blue)
        .padding()
}
