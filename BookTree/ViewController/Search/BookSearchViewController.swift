//
//  BookSearchViewController.swift
//  BookTree
//
//  Created by Nguyen Trung Tin on 14/11/2023.
//

import UIKit
import SwiftUI
import Combine

class BookSearchViewController: UIViewController {
    private let bookSearchViewModel: BookSearchViewModel
    private var cancellables: Set<AnyCancellable> = []
    var numberOfColumns: CGFloat = 3
    let space: CGFloat = 10
    
    var inSearchMode = false
    
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
        stackView.spacing = 20
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    lazy var searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.searchBarStyle = .minimal
        searchBar.placeholder = "Type some book name"
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        searchBar.delegate = self
        return searchBar
    }()
    
    lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.separatorStyle = .none
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //        let famillyNames = UIFont.familyNames
        //
        //        for famillyName in famillyNames {
        //            print("Family: \(famillyName)")
        //        }
        setupUI()
        setupData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.isNavigationBarHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        navigationController?.isNavigationBarHidden = false
    }
    
    func setupUI() {
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.register(BookTableViewCell.self, forCellReuseIdentifier: BookTableViewCell.identifier)
        view.backgroundColor = .systemMint
        view.addSubview(stackView)
        setupStackView()
    }
    
    func setupStackView() {
        navigationController?.setNavigationBarHidden(true, animated: false)
        stackView.addArrangedSubview(searchBar)
        stackView.addArrangedSubview(tableView)
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            stackView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    func setupData() {
        bookSearchViewModel.setSearchText("7 Habit")
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
        if searchBar.text == nil || searchBar.text == "" {
            view.endEditing(true)
            self.searchBar.showsCancelButton = false
        } else {
            self.searchBar.showsCancelButton = true
            bookSearchViewModel.setSearchText(searchText)
        }
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        self.view.endEditing(true)
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        self.view.endEditing(true)
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        inSearchMode = false
        self.searchBar.showsCancelButton = false
    }
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        inSearchMode = true
        self.searchBar.showsCancelButton = true
        bookSearchViewModel.setSearchText(searchBar.text ?? "")
    }
}

extension BookSearchViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let book = bookSearchViewModel.books[indexPath.row]
        
        let bookDetailViewController = BookDetailViewController()
        bookDetailViewController.book = book
        
        self.navigationController?.pushViewController(bookDetailViewController, animated: true)
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if inSearchMode {
            return 50
        } else {
            return 180
        }
    }
}

extension BookSearchViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        bookSearchViewModel.books.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if inSearchMode {
            let book = bookSearchViewModel.books[indexPath.row]
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
            var content = cell.defaultContentConfiguration()
            content.text = book.volumeInfo?.title
            cell.contentConfiguration = content
            return cell
        } else {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: BookTableViewCell.identifier, for: indexPath) as? BookTableViewCell else {
                return UITableViewCell()
            }
            let book = bookSearchViewModel.books[indexPath.row]
            cell.configure(book: book)
            return cell
        }
    }
}

// -MARK: Preview
struct BookSearchViewControllerPreview: PreviewProvider {
    static var previews: some View {
        VCPreview {
            let bookSearchlViewController = BookSearchViewController(bookSearchViewModel: BookSearchViewModel(apiCaller: APICaller()))
            return bookSearchlViewController
        }
    }
}
