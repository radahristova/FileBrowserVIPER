//
//  FileBrowserAPI.swift
//  MyFileBrowser
//
//  Created by  Rada Hristova on 20.02.23.
//

import Foundation

struct FileBrowserActivation {
    let url: URL
}

enum FileBrowser {
    struct ViewContent: Hashable {
        let title: String
    }
}

protocol FileBrowserViewControlling: NSObject {
    func showContents(_ content: [FileBrowser.ViewContent])
}

protocol FileBrowserPresenting {
    func viewDidLoad()
}

protocol FileBrowserInteracting {
    func loadURLs(with url: URL) -> Result<[URL], Error>
}
