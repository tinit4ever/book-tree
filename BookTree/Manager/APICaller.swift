//
//  APICaller.swift
//  BookTree
//
//  Created by Nguyen Trung Tin on 14/11/2023.
//


//https://www.googleapis.com/books/v1/volumes?q=search+terms

import Foundation
import Combine

struct Constants {
    static let baseURL = "https://www.googleapis.com/books/v1/volumes?q="
}

enum APIError: Error {
    case failedToGetData
    case badUrl
}

class APICaller {
    func fetchBooks(search: String) -> AnyPublisher<[BookAPI], Error> {
//        guard let encodedSearch = search.urlEncoded,
//              let url = URL(string: Constants.baseURL + encodedSearch)
//        else {
//            return Fail(error: APIError.badUrl).eraseToAnyPublisher()
//        }
        guard let url = URL(string: Constants.baseURL + search.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!) else {
                return Fail(error: APIError.badUrl).eraseToAnyPublisher()
            }
        
        return URLSession.shared.dataTaskPublisher(for: url)
            .map(\.data)
            .decode(type: BookAPIResponse.self, decoder: JSONDecoder())
            .map(\.items)
            .receive(on: DispatchQueue.main)
            .catch { error -> AnyPublisher<[BookAPI], Error> in
                return Just([]).setFailureType(to: Error.self).eraseToAnyPublisher()
            }
            .eraseToAnyPublisher()
    }
    
    func fetchBookDetails(urlString: String) -> AnyPublisher<BookAPI, Error> {
        print(urlString)
        guard let url = URL(string: urlString) else {
            return Fail(error: APIError.failedToGetData).eraseToAnyPublisher()
        }
        
        return URLSession.shared.dataTaskPublisher(for: url)
            .map(\.data)
            .decode(type: BookAPI.self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .retry(3)
            .eraseToAnyPublisher()
    }
}
