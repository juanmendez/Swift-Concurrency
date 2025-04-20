//
//  ContentView.swift
//  SwiftConcurrency
//
//  Created by Mendez, Juan on 4/16/25.
//

import SwiftUI

struct ContentView: View {
    @State var status = ""
    var body: some View {
        VStack {
            Text(status)
            Button {
                status = "Download"
                Task {
                    try? await cacheImages()
                }
            } label: {
                Text("Cache Images")
            }
        }
        .padding()
    }

    func cacheImages() async throws {
        let safeUrls = imageURLs.compactMap { URL(string: $0) }
        let startTime = Date.now
        var downloaded = 0

        await safeUrls.forEachAsyncInSequence { safeUrl in
            if let data = await safeUrl.fetchData(), let fileName = await data.cache() {
                downloaded += 1

                status =
                if downloaded == safeUrls.count {
                    "Duration: \(-startTime.timeIntervalSinceNow)"
                } else {
                    "Downloaded: \(fileName)"
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
