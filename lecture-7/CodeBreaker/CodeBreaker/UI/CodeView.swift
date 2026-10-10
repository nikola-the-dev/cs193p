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
    
    @ViewBuilder let ancillaryView: () -> AncillaryView
    
//    This init allows as to set default values
//    because @Binding variable above we cannot set with default values
//    also we can set here default value for @ViewBuilder variable
    init(code: Code,
         selection: Binding<Int> = Binding<Int>.constant(-1),
//         Don't forget to add this @ViewBuilder declaration
         @ViewBuilder ancillaryView: @escaping () -> AncillaryView = { EmptyView() })
    {
        self.code = code
//        It's because we sending Binding value so there is necessarry to append this value to its initial value that is marked with "_" symbol
        self._selection = selection
        self.ancillaryView = ancillaryView
    }
    
    
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
                    ancillaryView()
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
