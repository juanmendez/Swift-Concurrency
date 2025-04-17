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
                cacheImages()
            } label: {
                Text("Cache Images")
            }
        }
        .padding()
    }

    func cacheImages() {
        let myQ = DispatchQueue(label: "com.example.myQueue", attributes: .concurrent)

        let safeUrls = imageURLs.compactMap { URL(string: $0) }
        let startTime = Date.now
        var downloaded = 0

        safeUrls.forEach { safeUrl in
            myQ.async {
                if let data = safeUrl.fetchData(), let fileName = data.cache() {
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
}

#Preview {
    ContentView()
}
