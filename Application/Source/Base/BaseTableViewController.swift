//
//  BaseTableViewController.swift
//  DACP
//
//  Created by Aarif Sumra on 2021/07/08.
//  Copyright © 2021 Monstar-Lab Inc. All rights reserved.
//

import UIKit
import Combine
import CombineCocoa
import Domain

typealias ItemConfigurableTableViewCellWithReuseIdentifer = ItemConfigurable & UITableViewCell & HasReuseIdentifier

class BaseTableViewController<Model: ModelType, Cell: ItemConfigurableTableViewCellWithReuseIdentifer>: BaseViewController where Cell.Item == Model {
    
    // MARK: - Enums and Type aliases
    enum Section {
        case main
    }
    
    typealias DataSource = UITableViewDiffableDataSource<Section, Model>
    typealias Snapshot = NSDiffableDataSourceSnapshot<Section, Model>
    
    // MARK: - Lazys
    lazy var refreshControl = makeRefreshControl()
    lazy var noResultsLabel = makeNoResultsLabel()
    
    // MARK: - Outlets
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: - Properties
    private(set) var dataSource: DataSource!
    private var sections: [Section] = [.main]
    var clearsSelectionOnViewWillAppear = false
    
    // MARK: - View Lifecycle -
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureTableView()
        dataSource = makeDataSource()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if clearsSelectionOnViewWillAppear, let selectedRows = tableView.indexPathsForSelectedRows {
            for indexPath in selectedRows {
                tableView.deselectRow(at: indexPath, animated: animated)
            }
        }
    }
    
    func configureTableView() {
        let nib = UINib(nibName: String(describing: type(of: Cell())), bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: Cell.reuseIdentifier)
        tableView.keyboardDismissMode = .onDrag
        tableView.tableFooterView = UIView()
    }
    
    func makeDataSource() -> DataSource {
        return DataSource(
            tableView: tableView,
            cellProvider: { (tableView, indexPath, item) -> UITableViewCell? in
                guard let cell = tableView.dequeueReusableCell(withIdentifier: Cell.reuseIdentifier, for: indexPath) as? Cell else {
                    return UITableViewCell()
                }
                cell.configure(forItem: item)
                return cell
            }
        )
    }
    
    func loadTable(withInitialData items: [Model] = []) {
        // initial data
        var snapshot = Snapshot()
        snapshot.appendSections(sections)
        snapshot.appendItems([], toSection: .main)
        dataSource.apply(snapshot)
    }
    
    func updateTable(with items: [Model], animatingDifferences: Bool = false) {
        var currentSnapshot = dataSource.snapshot()
        currentSnapshot.appendItems(items, toSection: .main)
        dataSource.apply(currentSnapshot, animatingDifferences: animatingDifferences)
        
        refreshControl.endRefreshing()
        noResultsLabel.isHidden = !items.isEmpty
    }
}

private extension BaseTableViewController {
    
    func makeRefreshControl() -> UIRefreshControl {
        let refreshControl = UIRefreshControl()
        refreshControl.backgroundColor = .clear
        refreshControl.tintColor = .lightGray
        tableView.refreshControl = refreshControl
        return refreshControl
        
    }

    func makeNoResultsLabel() -> UILabel {
        let label = UILabel()
        label.text = "No Items Found!"
        label.textAlignment = .center
        label.sizeToFit()
        label.isHidden = true
        tableView.backgroundView = label
        return label
    }
}
