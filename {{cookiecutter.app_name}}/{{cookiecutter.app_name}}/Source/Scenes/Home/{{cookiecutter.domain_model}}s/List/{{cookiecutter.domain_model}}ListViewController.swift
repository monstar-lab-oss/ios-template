//
//  {{cookiecutter.domain_model}}ListViewController.swift
//  {{cookiecutter.app_name}}
//
//  Created by {{cookiecutter.lead_dev_name}} on {% now 'local' %}.
//  Copyright © {% now 'local', '%Y' %} {{cookiecutter.company_name}} All rights reserved.
//

import UIKit
import Combine
import Domain

class {{cookiecutter.domain_model}}ListViewController: UIViewController {

    enum Section {
        case main
    }

    typealias DataSource = UICollectionViewDiffableDataSource<Section, {{cookiecutter.domain_model}}>
    typealias Delegate = UICollectionViewDelegateFlowLayout
    typealias Snapshot = NSDiffableDataSourceSnapshot<Section, {{cookiecutter.domain_model}}>

    var viewModel: {{cookiecutter.domain_model}}ListViewModel?

    @IBOutlet private weak var collectionView: UICollectionView! {
        didSet {
            let nib = UINib(nibName: "{{cookiecutter.domain_model}}ListCell", bundle: nil)
            collectionView.register(nib, forCellWithReuseIdentifier: {{cookiecutter.domain_model}}ListCell.identifier)
            collectionView.keyboardDismissMode = .onDrag
        }
    }
    private weak var refreshControl: UIRefreshControl!
    private weak var noResultsLabel: UILabel!
    private var cancellables = Set<AnyCancellable>()
    private var dataSource: DataSource!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setupRefreshControl()
        setupNoResults()
        setupDataSource()

        let viewModelInput = {{cookiecutter.domain_model}}ListViewModel.Input(
            refresh: refreshControl.publisher(for: .valueChanged)
                .map { _ in () }
                .prepend(())
                .eraseToAnyPublisher(),
            selectedModel: Just(1).eraseToAnyPublisher()
        )
        let viewModelOutput = viewModel?.transform(viewModelInput)

        viewModelOutput?.results.receive(on: DispatchQueue.main)
            .catch { [weak self] error -> Just<[{{cookiecutter.domain_model}}]> in
                self?.noResultsLabel.text = error.localizedDescription
                return Just([])
            }.sink(receiveValue: { values in
                self.updateCollection(with: values)
            }).store(in: &cancellables)
    }

    func updateCollection(with items: [{{cookiecutter.domain_model}}]) {
        var snapshot = Snapshot()
        snapshot.appendSections([.main])
        snapshot.appendItems(items)
        dataSource.apply(snapshot)
    }
}

extension {{cookiecutter.domain_model}}ListViewController {

    func setupRefreshControl() {
        let refreshControl = UIRefreshControl()
        refreshControl.backgroundColor = .clear
        refreshControl.tintColor = .lightGray
        collectionView.refreshControl = refreshControl
        self.refreshControl = refreshControl
    }

    func setupNoResults() {
        let label = UILabel()
        label.text = "No {{cookiecutter.domain_model}}s Found!\n Please try different name again..."
        label.sizeToFit()
        label.isHidden = true
        collectionView.backgroundView = label
        noResultsLabel = label
    }

    func setupDataSource() {
        dataSource = DataSource(
            collectionView: collectionView,
            cellProvider: { (collectionView, indexPath, item) -> UICollectionViewCell? in
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: {{cookiecutter.domain_model}}ListCell.identifier, for: indexPath) as? {{cookiecutter.domain_model}}ListCell
                cell?.configure(forItem: item)
                return cell
            })
    }
}

extension {{cookiecutter.domain_model}}ListViewController {

}
