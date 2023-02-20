//
//  FileBrowserPresenter.swift
//  MyFileBrowser
//
//  Created by  Rada Hristova on 20.02.23.
//

import Foundation

class FileBrowserPresenter: FileBrowserPresenting {
    weak var view: FileBrowserViewControlling?
    private let interactor: FileBrowserInteracting
    private let activation: FileBrowserActivation
    
    var initialPaths: [URL]  {
        [activation.url]
    }
        
    init(interactor: FileBrowserInteracting, activation: FileBrowserActivation) {
        self.interactor = interactor
        self.activation = activation
    }
    
    func viewDidLoad() {
        guard let view else {
            return
        }
        buildViewContents(contents: initialPaths)
    }
    
    func buildViewContents(contents: [URL]) -> [FileBrowser.ViewContent] {
        let lastComponent = contents.last?.lastPathComponent ?? ""
        return [FileBrowser.ViewContent(title: lastComponent)]
    }
    
}
