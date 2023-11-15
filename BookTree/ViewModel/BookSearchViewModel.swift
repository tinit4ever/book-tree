//
//  BookListViewModel.swift
//  BookTree
//
//  Created by Nguyen Trung Tin on 14/11/2023.
//

import Foundation
import Combine

class BookSearchViewModel {
    @Published private(set) var books: [BookAPI] = []
    private var cancellables: Set<AnyCancellable> = []
    @Published var loadingCompleted: Bool = false
    
    private var searchSubject = CurrentValueSubject<String, Never>("")
    
    private let apiCaller: APICaller
    
    init(apiCaller: APICaller) {
        self.apiCaller = apiCaller
        setupSearchPublisher()
    }
    
    func setSearchText(_ searchText: String) {
        searchSubject.send(searchText)
    }
    
    func setupSearchPublisher() {
        searchSubject
            .debounce(for: .seconds(1), scheduler: DispatchQueue.main)
            .sink { [weak self] searchText in
                self?.loadBook(search: searchText)
            }
            .store(in: &cancellables)
    }
    
    func loadBook(search: String) {
        apiCaller.fetchBooks(search: search)
            .sink { completion in
                switch completion {
                case .finished:
                    self.loadingCompleted = true
                    break
                case .failure(let error):
                    print(error)
                }
            } receiveValue: { [weak self] books in
                self?.books = books
            }
            .store(in: &cancellables)
    }
}
