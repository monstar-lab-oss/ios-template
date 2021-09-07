//
//  PostDetailViewController.swift
//  Template
//
//  Created by Aarif Sumra on 2021-09-01.
//  Copyright © 2021 Monstar-Lab Inc. All rights reserved.
//

import UIKit
import Combine
import Domain

final class PostDetailViewController: UIViewController, StoryboardInstantiatable, ViewType {
    
    // MARK: - Statics
    static var storyboardName = "PostDetail"
    
    // MARK: - Enums and Type aliases
    enum Section {
        case main
    }

    typealias DataSource = UITableViewDiffableDataSource<Section, CommentEntity>
    typealias Snapshot = NSDiffableDataSourceSnapshot<Section, CommentEntity>
    
    // MARK: - Outlets
    @IBOutlet private weak var tableView: UITableView!
    @IBOutlet private var tableHeaderView: PostDetailHeaderView!
    
    // MARK: - Properties
    var viewModel: PostDetailViewModel!
    
    private weak var refreshControl: UIRefreshControl!
    private weak var noResultsLabel: UILabel!
    
    private var dataSource: DataSource!
    private var snapshot: Snapshot = .init()
    
    private var cancellables = Set<AnyCancellable>()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let nib = UINib(nibName: "CommentTableViewCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "commentCell")

        setupRefreshControl()
        setupNoResults()
        setupDataSource()
        layoutHeaderView()
        performBinding()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableHeaderView.layoutIfNeeded()
    }
    
    func performBinding() {
        assert(viewModel != nil)
        
        let viewModelInput = ViewModel.Input(
            refresh: Publishers.ControlEvent(control: refreshControl, events: .valueChanged)
                .map { _ in () }
                .prepend(())
                .eraseToAnyPublisher(),
            loadData: Just(()).eraseToAnyPublisher()
        )
        
        let viewModelOutput = viewModel.transform(viewModelInput)
        
        viewModelOutput.result.receive(on: RunLoop.main)
            .sink(receiveValue: { result in
                switch result {
                case .success(let item):
                    self.tableHeaderView.titleLabel.text = item.title
                    self.tableHeaderView.descriptionLabel.text = item.body
                case .failure(_):
                    print("No posts found")
                }
            }).store(in: &cancellables)
        
        viewModelOutput.comments.receive(on: RunLoop.main)
            .sink(receiveValue: { [weak self] result in
                switch result {
                case .success(let items):
                    self?.updateTable(with: items)
                    self?.refreshControl.endRefreshing()
                    if items.isEmpty {
                        self?.noResultsLabel.isHidden = false
                    }
                case .failure(_):
                    print("No posts found")
                }
            }).store(in: &cancellables)
        
    }
    
    private func layoutHeaderView() {
        tableHeaderView.translatesAutoresizingMaskIntoConstraints = false
        tableView.tableHeaderView = tableHeaderView
        NSLayoutConstraint.activate([
                                        tableHeaderView.topAnchor.constraint(equalTo: tableView.topAnchor),
                                        tableHeaderView.widthAnchor.constraint(equalTo: tableView.widthAnchor),
                                        tableHeaderView.centerXAnchor.constraint(equalTo: tableView.centerXAnchor)])
        tableHeaderView.layoutIfNeeded()
        tableView.tableHeaderView = tableHeaderView
    }
}


private extension PostDetailViewController {
    
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
                guard let cell = tableView.dequeueReusableCell(withIdentifier: "commentCell") as? CommentTableViewCell else {
                    return UITableViewCell()
                }
                cell.bodyLabel.text = item.body
                cell.nameLabel.text = item.name
                cell.emailLabel.text = item.email
                return cell
            })
    }
    
    func updateTable(with items: [CommentEntity]) {
        snapshot.appendItems(items)
        dataSource.apply(snapshot)
    }
}



final class PostDetailHeaderView: UIView {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
}
