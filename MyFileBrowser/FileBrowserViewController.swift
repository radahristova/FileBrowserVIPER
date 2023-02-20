//
//  ViewController.swift
//  MyFileBrowser
//
//  Created by Rada Hristova on 15.02.23.
//

import UIKit
import EasyPeasy

enum Section: Hashable {
    case all
}

class FileBrowserViewController: UIViewController {
    typealias DataSource = UICollectionViewDiffableDataSource<Section, FileBrowser.ViewContent>
    typealias Snapshot = NSDiffableDataSourceSnapshot<Section, FileBrowser.ViewContent>
    typealias CellRegistration = UICollectionView.CellRegistration<FileCollectionViewCell, FileBrowser.ViewContent>

    private let presenter: FileBrowserPresenting
    private var collectionView: UICollectionView!
    private lazy var dataSource = configureDataSource()

//    lazy var itemsURLs: [URL] = [] {
//        didSet {
//            collectionView?.reloadData()
//        }
//    }

//    private let fileManager: MyFileManager
//    private let initialPath: URL

    init(presenter: FileBrowserPresenting) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        let configuration = UICollectionLayoutListConfiguration(appearance: .plain)
        let layout = UICollectionViewCompositionalLayout.list(using: configuration)
        self.collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        view.addSubview(collectionView)
        
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        applyConstraints()
        collectionView.dataSource = dataSource
        collectionView.delegate = self

//        loadItemsURLs()
//        applySnapshot(animatingDifferences: false)
        presenter.viewDidLoad()
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

    private func applyConstraints() {
        collectionView.easy.layout(
            Top(),
            Leading(),
            Trailing(),
            Bottom()
        )
    }


//    private func loadItemsURLs() {
//        switch fileManager.contentsOfDirectory(in: initialPath) {
//        case .success(let urls):
//            itemsURLs = urls
//        case .failure(let error):
//            print(error)
//        }
//    }
}

extension FileBrowserViewController: FileBrowserViewControlling {
    func showContents(_ content: [FileBrowser.ViewContent]) {
        let snapshot = applySnapshot(with: content)
        dataSource.apply(snapshot)
        self.collectionView.reloadData()
    }
}

extension FileBrowserViewController: UICollectionViewDelegate {
//    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        guard let item = dataSource.itemIdentifier(for: indexPath) else { return }
//        let vc = FileBrowserViewController(initialPath: item, filemanager: fileManager)
//        vc.title = itemsURLs[indexPath.row].lastPathComponent
//        navigationController?.pushViewController(vc, animated: true)
//    }
}
