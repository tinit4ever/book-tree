//
//  BookDetailViewModel.swift
//  BookTree
//
//  Created by Nguyen Trung Tin on 14/11/2023.
//

import Foundation
import Combine

class BookDetailViewModel {
    @Published private(set) var book: BookAPI?
    private var cancellables: Set<AnyCancellable> = []
    @Published var loadingDetailCompleted: Bool = false
    
    private var didSelectSubject = CurrentValueSubject<String, Never>("")
    
    private let apiCaller: APICaller
    
    init(apiCaller: APICaller) {
        self.apiCaller = apiCaller
        setupDidSelectPublisher()
    }
    
    func setupDidSelectPublisher() {
        didSelectSubject
            .sink { [weak self] url in
                self?.loadBookDetails(url: url)
            }
            .store(in: &cancellables)
    }
    
    func setUrl(_ url: String) {
        didSelectSubject.send(url)
    }
    
    func loadBookDetails(url: String) {
        apiCaller.fetchBookDetails(urlString: url)
            .sink { completion in
                switch completion {
                case .finished:
                    self.loadingDetailCompleted = true
                    break
                case .failure(let error):
                    print("Error \(error)")
                }
            } receiveValue: { [weak self] book in
                self?.book = book
            }
            .store(in: &cancellables)
    }
}
