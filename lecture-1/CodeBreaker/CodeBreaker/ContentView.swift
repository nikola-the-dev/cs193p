//
//  ContentView.swift
//  CodeBreaker
//
//  Created by Nick Voloshyn on 08.09.2026.
//

import SwiftUI

struct ContentView: View {
//
//    Struct can't inherits from something
//    : - in this context it means that ContentView act as like View
//    but NOT inherits from View
//
//    Protocol is a description of action
//
//    Almost everything in Swift are structures
//
    var body: some View {
//        This is computable variable and it computes each time as it calls
//        It calls as a function without arguments that returns only some variable
        VStack(alignment: .leading, spacing: 10.0, content: greetings)
            .padding()
    }
    
    @ViewBuilder
    func greetings() -> some View {
        Image(systemName: "globe")
            .imageScale(.large)
            .foregroundStyle(.tint)
        Text("Hello, world!")
            .font(.largeTitle)
    }
}

#Preview {
    ContentView()
}
