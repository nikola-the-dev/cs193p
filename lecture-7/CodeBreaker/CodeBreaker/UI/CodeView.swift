//
//  CodeView.swift
//  CodeBreaker
//
//  Created by Nick Voloshyn on 06.10.2026.
//

import SwiftUI

struct CodeView<AncillaryView>: View where AncillaryView: View {
    
    let code: Code
    
    @Binding var selection: Int
    
    let ancillaryView: AncillaryView
    
    
    var body: some View {
        HStack {
            ForEach(code.pegs.indices, id: \.self) { i in
                PegView(peg: code.pegs[i])
                    .padding(Selection.border)
                    .background {
                        if selection == i, code.kind == .guess {
                            Selection.shape
                                .foregroundStyle(Selection.color)
                        }
                    }
                    .overlay {
                        Selection.shape
                            .foregroundStyle(code.isHidden ? Color.gray : .clear)
                    }
                    .onTapGesture {
                        if code.kind == .guess {
                            selection = i
                        }
                    }
            }

            Color.clear.aspectRatio(1, contentMode: .fit)
                .overlay {
                    ancillaryView
                }
        }

        
    }
    
    
}


fileprivate struct Selection {
    static let border: CGFloat = 5.0
    static let cornerRadius: CGFloat = 5.0
    static let color: Color = Color.gray(0.85)
    static let shape: some View = RoundedRectangle(cornerRadius: cornerRadius)
}



//#Preview {
//    CodeView()
//}
