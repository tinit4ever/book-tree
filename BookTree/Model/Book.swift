//
//  Book.swift
//  BookTree
//
//  Created by Nguyen Trung Tin on 14/11/2023.
//

import Foundation

struct BookAPIResponse: Decodable {
    let items: [BookAPI]
}

struct BookAPI: Decodable {
    let kind: String?
    let selfLink: String?
    let volumeInfo: VolumeInfo?
}

struct VolumeInfo: Decodable {
    let title: String?
    let authors: [String]?
//    let publisher: String?
    let description: String?
    let pageCount: Int?
    let categories: [String]?
    let imageLinks: ImageLink?
    let publishedDate: String?
    let language: String?
    let averageRating: Double?
}

struct ImageLink: Decodable {
    let thumbnail: String?
}
