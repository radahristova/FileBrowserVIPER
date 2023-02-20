//
//  FileBrowserCollectionViewContentController.swift
//  MyFileBrowser
//
//  Created by  Rada Hristova on 20.02.23.
//

import Foundation
import UIKit


extension FileBrowserViewController {
    final class CollectionViewContentController {
        typealias DataSource = UICollectionViewDiffableDataSource<Section, FileBrowser.ViewContent>
        typealias Snapshot = NSDiffableDataSourceSnapshot<Section, FileBrowser.ViewContent>
        typealias CellRegistration = UICollectionView.CellRegistration<FileCollectionViewCell, FileBrowser.ViewContent>
        
        private var collectionView: UICollectionView!
        private lazy var dataSource = configureDataSource()
        
        
//        let configuration = UICollectionLayoutListConfiguration(appearance: .plain)
//        let layout = UICollectionViewCompositionalLayout.list(using: configuration)
//        self.collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout
        
        enum Section {
            case all
        }
//        enum Cell: Hashable {
//            case all([FileBrowser.ViewContent])
//        }
                                               
        init(collectionView: UICollectionView) {
            self.collectionView = collectionView
//
//            collectionView.collectionViewLayout = createLayout()
//            dataSource = createDataSource(collectionView: collectionView)
            let configuration = UICollectionLayoutListConfiguration(appearance: .plain)
            let layout = UICollectionViewCompositionalLayout.list(using: configuration)
            self.collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
            dataSource = configureDataSource()
        }
        
        private func configureCellRegistration() -> CellRegistration {
            return CellRegistration { (cell, indexpath, item ) in
                cell.folderNameLabel.text = item.title
//                if url.hasDirectoryPath {
//                    cell.folderNameLabel.font = .boldSystemFont(ofSize: 17)
//                } else {
//                    cell.folderNameLabel.font = .systemFont(ofSize: 17)
//                }
            }
        }
        
        private func configureDataSource() -> DataSource {
            let cellRegistration = configureCellRegistration()
            let dataSource = DataSource(
               collectionView: collectionView,
               cellProvider: { (collectionView, indexPath, item) ->
                 UICollectionViewCell? in
                   let cell = collectionView.dequeueConfiguredReusableCell(using: cellRegistration, for: indexPath, item: item)
                   return cell
             })
            return dataSource
        }

        func applySnapshot(with contents: [FileBrowser.ViewContent]) -> NSDiffableDataSourceSnapshot<Section, FileBrowser.ViewContent>  {
            var snapshot = NSDiffableDataSourceSnapshot<Section, FileBrowser.ViewContent>()
          snapshot.appendSections([.all])
            snapshot.appendItems(contents)
//            snapshot.appendItems([contents.title])
            return snapshot
        }
        
        func setContents(_ contents: [FileBrowser.ViewContent]) {
            let snapshot = applySnapshot(with: contents)

            dataSource.apply(snapshot, animatingDifferences: true)
        }
    }
}
