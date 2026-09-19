//
//  ContentView.swift
//  CodeBreaker
//
//  Created by Nick Voloshyn on 08.09.2026.
//

import SwiftUI

struct ContentViewMoreExamFromL1: View {
//
//    Basically struct can not inherits from something (as a class)
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
        VStack(content: greetingsClean)
            .font(.largeTitle)
//        It applies style to all elems inside this component that has no specified font modifier
//        because font can not be applied to the VStack-element
//        But if we apply padding modifier here it applies only VStack-component
//        and NOT applies to the comps inside
    }
    
    @ViewBuilder
    func greetings() -> some View {
        Image(systemName: "globe")
            .font(.largeTitle)
//        For system images we can apply font style and it acts as text
        Text("Hello, world!")
            .font(.largeTitle)
            .foregroundStyle(.green)
        Text("Greetings!")
            .padding()
            .background(.yellow)
//        Order matters because in this case yellow bg applied to whole area including paddings
//        If we apply:
//            .background(.yellow)
//            .padding()
//        In this case it fill the bg in yellow and than applies padding
    }
    
    @ViewBuilder
    func greetingsClean() -> some View {
        Image(systemName: "globe")
        Text("Hello, world!")
        Text("Greetings!")
            
    }
}

#Preview {
    ContentViewMoreExamFromL1()
}
