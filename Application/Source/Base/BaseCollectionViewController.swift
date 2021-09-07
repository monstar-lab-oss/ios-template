//
//  BaseMoviesViewController.swift
//  BoxOffice
//
//  Created by Sumra Aarif on 2021/01/22.
//  Copyright © 2021 Monstar-Lab Inc. All rights reserved.
//
import UIKit
import Combine
import Domain

typealias ItemConfigurableCollectionViewCellWithReuseIdentifer = ItemConfigurable & UICollectionViewCell & HasReuseIdentifier

class BaseCollectionViewController<Model: ModelType, Cell: ItemConfigurableCollectionViewCellWithReuseIdentifer>: BaseViewController where Cell.Item == Model {
    // Enums
    enum Section {
        case main
    }
    
    // Typealiases
    typealias DataSource = UICollectionViewDiffableDataSource<Section, Model>
    typealias Delegate = UICollectionViewDelegateFlowLayout
    typealias Snapshot = NSDiffableDataSourceSnapshot<Section, Model>

    // Lazys
    lazy var dataSource: DataSource = {
        DataSource(
            collectionView: collectionView,
            cellProvider: { (collectionView, indexPath, item) -> UICollectionViewCell? in
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Cell.reuseIdentifier, for: indexPath) as? Cell
                cell?.configure(forItem: item)
                return cell
            }
        )
    }()
    lazy var snapshot: Snapshot = {
        var snapshot: Snapshot = .init()
        snapshot.appendSections([.main])
        return snapshot
    }()

    weak var refreshControl: UIRefreshControl!
    weak var noResultsLabel: UILabel!
    // IBOutlets
    @IBOutlet weak var collectionView: UICollectionView!

    override func viewDidLoad() {
        super.viewDidLoad()
        setupRefreshControl()
        setupNoResultsLabel()
        setupCollectionView()
    }

    func updateCollection(with items: [Model]) {
        snapshot.appendItems(items)
        dataSource.apply(snapshot)
    }
    
    func setupCollectionView() {
        let nib = UINib(nibName: String(describing: type(of: Cell())), bundle: nil)
        collectionView.register(nib, forCellWithReuseIdentifier: Cell.reuseIdentifier)
        collectionView.keyboardDismissMode = .onDrag
    }

    func setupRefreshControl() {
        let refreshControl = UIRefreshControl()
        refreshControl.backgroundColor = .clear
        refreshControl.tintColor = .lightGray
        collectionView.refreshControl = refreshControl
        self.refreshControl = refreshControl
    }

    func setupNoResultsLabel() {
        let label = UILabel()
        label.text = "No Items Found!"
        label.textAlignment = .center
        label.sizeToFit()
        label.isHidden = true
        collectionView.backgroundView = label
        noResultsLabel = label
    }
}
