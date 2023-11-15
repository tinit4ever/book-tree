//
//  BookSearchViewController.swift
//  BookTree
//
//  Created by Nguyen Trung Tin on 14/11/2023.
//

import UIKit
import Combine

class BookSearchViewController: UIViewController {
    private let bookSearchViewModel: BookSearchViewModel
    private var cancellables: Set<AnyCancellable> = []
    
    init(bookSearchViewModel: BookSearchViewModel) {
        self.bookSearchViewModel = bookSearchViewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    lazy var searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.showsCancelButton = true
        searchBar.searchBarStyle = .minimal
        searchBar.placeholder = "Type some book name"
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        searchBar.delegate = self
        return searchBar
    }()
    
    lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupData()
    }
    
    func setupUI() {
        view.backgroundColor = .systemBackground
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        view.addSubview(stackView)
        setupStackView()
    }
    
    func setupStackView() {
        stackView.addArrangedSubview(searchBar)
        stackView.addArrangedSubview(tableView)
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            stackView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
        NSLayoutConstraint.activate([
        ])
    }
    
    func setupData() {
        bookSearchViewModel.$loadingCompleted
            .receive(on: DispatchQueue.main)
            .sink { [weak self] completed in
                if completed {
                    self?.tableView.reloadData()
                }
            }
            .store(in: &cancellables)
    }
}

extension BookSearchViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        bookSearchViewModel.setSearchText(searchText)
    }
}

extension BookSearchViewController: UITableViewDelegate {
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        let bookURL = bookSearchViewModel.books[indexPath.row].selfLink
//        
//        let bookDetailViewController = BookDetailViewController(bookDetailViewModel: BookDetailViewModel(apiCaller: APICaller()))
//        bookDetailViewController.selectedUrl = bookURL
//        self.navigationController?.pushViewController(bookDetailViewController, animated: true)
//    }
}

extension BookSearchViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        bookSearchViewModel.books.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let book = bookSearchViewModel.books[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        var content = cell.defaultContentConfiguration()
        content.text = book.volumeInfo?.title
        cell.contentConfiguration = content
        return cell
    }
}

