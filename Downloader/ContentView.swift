//
//  ContentView.swift
//  Downloader
//
//  Created by Chris Eidhof on 15.11.21.
//

import SwiftUI

let urls = [
    URL(string: "https://www.objc.io/index.html")!,
    URL(string: "http://ftp.acc.umu.se/mirror/wikimedia.org/dumps/enwiki/20211101/enwiki-20211101-abstract.xml.gz")!
]

struct DownloadView: View {
    @ObservedObject var model: DownloadModel
    
    var body: some View {
        VStack {
            Text("\(model.url)")
            switch model.state {
            case .notStarted:
                Button("Start") {
                    Task {
                        try await model.start()
                    }
                }
            case .inProgress:
                ProgressView()
                    .progressViewStyle(.linear)
            case let .done(url):
                Text("Done: \(url)")
            }
        }
    }
}

struct ContentView: View {
    var body: some View {
        VStack {
            ForEach(urls, id: \.self) { url in
                DownloadView(model: DownloadModel(url))
            }
        }
        .padding()
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
