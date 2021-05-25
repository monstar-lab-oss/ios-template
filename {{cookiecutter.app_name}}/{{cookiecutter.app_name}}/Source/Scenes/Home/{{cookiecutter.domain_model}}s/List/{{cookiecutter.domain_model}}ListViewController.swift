//
//  {{cookiecutter.domain_model}}ListViewController.swift
//  {{cookiecutter.app_name}}
//
//  Created by {{cookiecutter.lead_dev_name}} on {% now 'local' %}.
//  Copyright © {% now 'local', '%Y' %} {{cookiecutter.company_name}} All rights reserved.
//

import UIKit
import Combine
import CombineCocoa
import Domain

class {{cookiecutter.domain_model}}ListViewController: UIViewController {
    // MARK: - Enums and Type aliases
    enum Section {
        case main
    }

    typealias DataSource = UITableViewDiffableDataSource<Section, {{cookiecutter.domain_model}}>
    typealias Snapshot = NSDiffableDataSourceSnapshot<Section, {{cookiecutter.domain_model}}>
    
    // MARK: - Outlets
    @IBOutlet private weak var tableView: UITableView!

    // MARK: - Properties
    private weak var refreshControl: UIRefreshControl!
    private weak var noResultsLabel: UILabel!
    private var dataSource: DataSource!
    private var snapshot: Snapshot = .init()
    
    private var viewModel: {{cookiecutter.domain_model}}ListViewModel!
    private var cancellables = Set<AnyCancellable>()
    private var itemSelectedPublisher: PassthroughSubject<Int, Never> = .init()
    
    // MARK: - Init
    class func instantiate(with viewModel: {{cookiecutter.domain_model}}ListViewModel) -> {{cookiecutter.domain_model}}ListViewController {
        let name = "{{cookiecutter.domain_model}}List"
        let storyboard = UIStoryboard(name: name, bundle: nil)

        guard let vc = storyboard.instantiateInitialViewController() as? {{cookiecutter.domain_model}}ListViewController else {
            preconditionFailure("Unable to instantiate a {{cookiecutter.domain_model}}ListViewController with the name \(name)")
        }

        vc.viewModel = viewModel
        return vc
    }

    // MARK: - View Lifecycle -
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        setupRefreshControl()
        setupNoResults()
        setupDataSource()
        
        let viewModelInput = {{cookiecutter.domain_model}}ListViewModel.Input(
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
            .catch { [weak self] error -> Just<[{{cookiecutter.domain_model}}]> in
                self?.noResultsLabel.text = error.localizedDescription
                return Just([])
            }.sink(receiveValue: { values in
                self.updateTable(with: values)
            }).store(in: &cancellables)
    }
}

extension {{cookiecutter.domain_model}}ListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let item = dataSource.itemIdentifier(for: indexPath) else { return }
        itemSelectedPublisher.send(item.id)
    }
}

private extension {{cookiecutter.domain_model}}ListViewController {
    
    func setupRefreshControl() {
        let refreshControl = UIRefreshControl()
        refreshControl.backgroundColor = .clear
        refreshControl.tintColor = .lightGray
        tableView.refreshControl = refreshControl
        self.refreshControl = refreshControl
    }

    func setupNoResults() {
        let label = UILabel()
        label.text = "No {{cookiecutter.domain_model}}s Found!\n Please try different name again..."
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
    
    func updateTable(with items: [{{cookiecutter.domain_model}}]) {
        snapshot.appendItems(items)
        dataSource.apply(snapshot)
    }
}
