//
//  BookDetailViewController.swift
//  BookTree
//
//  Created by Nguyen Trung Tin on 14/11/2023.
//

import UIKit
import Combine

class BookDetailViewController: UIViewController {
    var selectedUrl: String?
    private let bookDetailViewModel: BookDetailViewModel
    private var cancellables: Set<AnyCancellable> = []
    
    init(bookDetailViewModel: BookDetailViewModel) {
        self.bookDetailViewModel = bookDetailViewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupData()
    }
    
    func setupUI() {
        view.backgroundColor = .systemBackground
        
        view.addSubview(descriptionLabel)
        NSLayoutConstraint.activate([
            descriptionLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            descriptionLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
    
    func setupData() {
        guard let url = selectedUrl else {
            return
        }
        bookDetailViewModel.setUrl(url)
        bookDetailViewModel.$loadingDetailCompleted
            .receive(on: DispatchQueue.main)
            .sink { [weak self] completed in
                if completed {
                    self?.descriptionLabel.text = self?.bookDetailViewModel.book?.volumeInfo.description
                }
            }
            .store(in: &cancellables)
    }
}
