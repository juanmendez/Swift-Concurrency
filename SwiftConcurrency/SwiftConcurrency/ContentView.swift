//
//  ContentView.swift
//  SwiftConcurrency
//
//  Created by Mendez, Juan on 4/16/25.
//

import SwiftUI

struct ContentView: View {
    @State var message = ""
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text(message)
        }
        .padding()
        .onAppear {
            threadStuff()
        }
    }

    func threadStuff() {
        let myQ = DispatchQueue(label: "myQ")
        for x in 0..<10 {
            myQ.async {
                message += "\(x)\n"
            }
        }

    }
}

#Preview {
    ContentView()
}
