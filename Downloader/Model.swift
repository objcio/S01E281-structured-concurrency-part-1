//
//  Model.swift
//  Downloader
//
//  Created by Chris Eidhof on 15.11.21.
//

import Foundation


final class DownloadModel: ObservableObject {
    let url: URL
    init(_ url: URL) {
        self.url = url
    }
    
    enum State {
        case notStarted
        case inProgress
        case done(URL)
    }
    
    @MainActor @Published var state = State.notStarted
    
    @MainActor
    func start() async throws {
        state = .inProgress
        let (localURL, _) = try await URLSession.shared.download(from: url, delegate: nil)
        self.state = .done(localURL)
    }
}
