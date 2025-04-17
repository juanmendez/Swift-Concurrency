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
                status = "Downloading..."
                cacheImages()
            } label: {
                Text("Cache Images")
            }
        }
        .padding()
    }

    func cacheImages() {
        let startTime = Date.now

        var safeImagesCached = [String]()

        imageURLs.map { url in
            if let safeUrl = URL(string: url), let data = safeUrl.fetchData() {
                return data.cache()
            } else {
                return nil
            }
        }.forEach {
            if let urlString = $0 {
                safeImagesCached.append(urlString)
            }
        }

        var count = 0
        safeImagesCached.forEach { filename in
            count += 1
            print("\(count) of \(imageURLs.count) - \(Date.now) - \(filename)")

            if count == safeImagesCached.count {
                status = "Duration: \(-startTime.timeIntervalSinceNow)"
            } else {
                status = "Downloaded: \(count) of \(imageURLs.count)"
            }
        }

        print(status)
    }
}

#Preview {
    ContentView()
}
