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
        var downloaded = 0

        var urls = [URL]()
        await safeUrls.forEachAsyncInParallel { safeUrl in
            if let data = await safeUrl.fetchDataDeferred(), let fileName = await data.cache() {
                urls.append(safeUrl)
                downloaded += 1

                status =
                    if downloaded == safeUrls.count {
                        "Duration: \(-startTime.timeIntervalSinceNow)"
                    } else {
                        "Downloaded: \(fileName)"
                    }
            }
        }

        return urls
    }
}

#Preview {
    ContentView()
}
