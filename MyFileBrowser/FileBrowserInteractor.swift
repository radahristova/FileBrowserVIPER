//
//  FileBrowserInteractor.swift
//  MyFileBrowser
//
//  Created by  Rada Hristova on 20.02.23.
//

import Foundation

class FileBrowserInteractor: FileBrowserInteracting {
    func loadURLs(with url: URL) -> Result<[URL], Error> {
        do {
            let itemsURLs = try FileManager.default.contentsOfDirectory(at: url, includingPropertiesForKeys: nil)
            return .success(itemsURLs)
        } catch {
            return .failure(error)
        }
    }
}
