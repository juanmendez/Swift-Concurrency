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
        let _ = DispatchQueue.main
        let globalQ = DispatchQueue.global()

        globalQ.async {
            let thread = Thread.current

            message = if thread.isMainThread {
                "main thread"
            } else {
                "not main thread"
            }
        }


    }
}

#Preview {
    ContentView()
}
