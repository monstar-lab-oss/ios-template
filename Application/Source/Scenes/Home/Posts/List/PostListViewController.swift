//
//  PostListViewController.swift
//  Template
//
//  Created by Aarif Sumra on 2021-09-01.
//  Copyright © 2021 Monstar-Lab Inc. All rights reserved.
//

import UIKit
import Combine
import CombineCocoa
import Domain

final class PostListViewController: UIViewController, StoryboardInstantiatable, ViewType {
    
    // MARK: - Statics
    static var storyboardName  = "PostList"
    
    // MARK: - Enums and Type aliases
    enum Section {
        case main
    }

    typealias DataSource = UITableViewDiffableDataSource<Section, PostEntity>
    typealias Snapshot = NSDiffableDataSourceSnapshot<Section, PostEntity>
    
    // MARK: - Outlets
    @IBOutlet private weak var tableView: UITableView!

    // MARK: - Properties
    var viewModel: PostListViewModel!

    private weak var refreshControl: UIRefreshControl!
    private weak var noResultsLabel: UILabel!
    
    private var dataSource: DataSource!
    private var snapshot: Snapshot = .init()
    
    private var cancellables = Set<AnyCancellable>()
    private var itemSelectedPublisher: PassthroughSubject<Int, Never> = .init()

    // MARK: - View Lifecycle -
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        setupRefreshControl()
        setupNoResults()
        setupDataSource()
        performBinding()
    }
    
    func performBinding() {
        assert(viewModel != nil)
        let viewModelInput = PostListViewModel.Input(
            refresh: Publishers.ControlEvent(control: refreshControl, events: .valueChanged)
                .map { _ in () }
                .prepend(())
                .eraseToAnyPublisher(),
            itemSelected: itemSelectedPublisher
                .eraseToAnyPublisher(),
            loadMore: tableView.reachedBottomPublisher()
                .debounce(for: 0.1, scheduler: RunLoop.main)
                .eraseToAnyPublisher()
        )
        
        let viewModelOutput = viewModel?.transform(viewModelInput)
        
        viewModelOutput?.results.receive(on: DispatchQueue.main)
            .sink(receiveValue: { [weak self] values in
                self?.updateTable(with: values)
                self?.refreshControl.endRefreshing()
                if values.isEmpty {
                    self?.noResultsLabel.isHidden = false
                }
            }).store(in: &cancellables)
    }
}

extension PostListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let item = dataSource.itemIdentifier(for: indexPath) else { return }
        itemSelectedPublisher.send(item.id)
    }
}

private extension PostListViewController {
    
    func setupRefreshControl() {
        let refreshControl = UIRefreshControl()
        refreshControl.backgroundColor = .clear
        refreshControl.tintColor = .lightGray
        tableView.refreshControl = refreshControl
        self.refreshControl = refreshControl
    }

    func setupNoResults() {
        let label = UILabel()
        label.text = "No Posts Found!\n Please try different name again..."
        label.sizeToFit()
        label.isHidden = true
        tableView.backgroundView = label
        noResultsLabel = label
    }

    func setupDataSource() {
        snapshot.appendSections([.main])
        dataSource = DataSource(
            tableView: tableView,
            cellProvider: { (tableView, indexPath, item) -> UITableViewCell? in
                let cell = UITableViewCell(style: .subtitle, reuseIdentifier: "cell") // For simplicity
                cell.textLabel?.text = item.title
                cell.detailTextLabel?.text = item.body
                return cell
            })
    }
    
    func updateTable(with items: [PostEntity]) {
        snapshot.appendItems(items)
        dataSource.apply(snapshot)
    }
}
