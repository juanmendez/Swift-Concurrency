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
                    let urls = try? await cacheImages()
                    if let urls {
                        print(urls)
                    }
                }
            } label: {
                Text("Cache Images")
            }
        }
        .padding()
    }

    func cacheImages() async throws -> [URL] {
        let safeUrls = imageURLs.compactMap { URL(string: $0) }
        let startTime = Date.now
        let downLoadCounter = DownloadCounter()

        var urls = [URL]()
        await safeUrls.forEachAsyncInParallel { safeUrl in
            if let data = await safeUrl.fetchDataDeferred(), let fileName = await data.cache() {
                urls.append(safeUrl)
                await downLoadCounter.increment()

                status =
                if await downLoadCounter.count == safeUrls.count {
                        "Duration: \(-startTime.timeIntervalSinceNow)"
                    } else {
                        "Downloaded: \(fileName)"
                    }
            }
        }

        return urls
    }
}

actor DownloadCounter {
    var count = 0

    func increment() {
        count += 1
    }
}

#Preview {
    ContentView()
}
