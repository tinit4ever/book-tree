//
//  BookDetailViewController.swift
//  BookTree
//
//  Created by Nguyen Trung Tin on 14/11/2023.
//

import UIKit
import SwiftUI
import Combine

class BookDetailViewController: UIViewController {
    //    var selectedUrl: String?
    //    private let bookDetailViewModel: BookDetailViewModel
    //    private var cancellables: Set<AnyCancellable> = []
    //
    //    init(bookDetailViewModel: BookDetailViewModel) {
    //        self.bookDetailViewModel = bookDetailViewModel
    //        super.init(nibName: nil, bundle: nil)
    //    }
    //
    //    required init?(coder: NSCoder) {
    //        fatalError("init(coder:) has not been implemented")
    //    }
    
    // MARK: - Create UI Component
    
    lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.distribution = .fill
        stackView.spacing = 20
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    lazy var imageView: UIImageView = {
        let imageView = UIImageView(frame: .zero)
        imageView.image = UIImage(named: "sampleImage")
        imageView.contentMode = .scaleAspectFit
        imageView.layer.cornerRadius = 10
        imageView.backgroundColor = .black
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.text = "Title"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var authorLabel: UILabel = {
        let label = UILabel()
        label.textColor = .gray
        label.text = "Author"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var contentStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 10
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    lazy var pageCountStack: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.addArrangedSubview(pageCountContentLabel)
        stackView.addArrangedSubview(pageCountTitleLabel)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    lazy var pageCountTitleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .gray
        label.text = "Page"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var pageCountContentLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.text = "400"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var languageStack: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.addArrangedSubview(languageContentLabel)
        stackView.addArrangedSubview(languageTitleLabel)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    lazy var languageTitleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .gray
        label.text = "Language"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var languageContentLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.text = "EN"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var releaseStack: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.addArrangedSubview(releaseContentLabel)
        stackView.addArrangedSubview(releaseTitleLabel)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    lazy var releaseTitleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .gray
        label.text = "Release"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var releaseContentLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.text = "2023-01-01"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var descriptionScrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.isScrollEnabled = true
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.showsVerticalScrollIndicator = true
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
    
    lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 0
        label.text = "Sure, here is a one-paragraph summary of The 7 Habits of Highly Effective People: To achieve personal and professional success, Stephen R. Covey advocates for adopting seven key principles: proactive responsibility for one's life, starting with a clear vision of goals, prioritizing tasks based on importance, seeking mutually beneficial solutions, listening empathetically before communicating, valuing others' strengths for collaboration, and continuous self-improvement in all aspects of life. Sure, here is a one-paragraph summary of The 7 Habits of Highly Effective People: To achieve personal and professional success, Stephen R. Covey advocates for adopting seven key principles: proactive responsibility for one's life, starting with a clear vision of goals, prioritizing tasks based on importance, seeking mutually beneficial solutions, listening empathetically before communicating, valuing others' strengths for collaboration, and continuous self-improvement in all aspects of life. Sure, here is a one-paragraph summary of The 7 Habits of Highly Effective People: To achieve personal and professional success, Stephen R. Covey advocates for adopting seven key principles: proactive responsibility for one's life, starting with a clear vision of goals, prioritizing tasks based on importance, seeking mutually beneficial solutions, listening empathetically before communicating, valuing others' strengths for collaboration, and continuous self-improvement in all aspects of life"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var dividerView: UIView = {
        let view = UIView()
        view.backgroundColor = .gray
        view.translatesAutoresizingMaskIntoConstraints = false
        view.widthAnchor.constraint(equalToConstant: 2).isActive = true
        return view
    }()
    
    lazy var secondDividerView: UIView = {
        let view = UIView()
        view.backgroundColor = .gray
        view.translatesAutoresizingMaskIntoConstraints = false
        view.widthAnchor.constraint(equalToConstant: 2).isActive = true
        return view
    }()
    
    // MARK: - Did Load
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        //        setupData()
    }
    
    // MARK: - Setup UI
    
    func setupUI() {
        view.backgroundColor = .systemBackground
        view.addSubview(stackView)
        setupStackView()
        
        stackView.addArrangedSubview(imageView)
        setupImageView()
        
        stackView.addArrangedSubview(titleLabel)
        stackView.addArrangedSubview(authorLabel)
        view.addSubview(contentStackView)
        setupContentStackView()
        
        view.addSubview(descriptionScrollView)
        setupDescriptionScrollView()
    }
    
    func setupStackView() {
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            stackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor)
        ])
    }
    
    func setupImageView() {
        NSLayoutConstraint.activate([
            imageView.heightAnchor.constraint(equalToConstant: 182),
            imageView.widthAnchor.constraint(equalToConstant: 120),
        ])
    }
    
    func setupContentStackView() {
        contentStackView.addArrangedSubview(pageCountStack)
        contentStackView.addArrangedSubview(dividerView)
        contentStackView.addArrangedSubview(languageStack)
        contentStackView.addArrangedSubview(secondDividerView)
        contentStackView.addArrangedSubview(releaseStack)
        NSLayoutConstraint.activate([
            contentStackView.topAnchor.constraint(equalTo: stackView.bottomAnchor, constant: 20),
            contentStackView.heightAnchor.constraint(equalToConstant: 40),
            languageStack.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }
    
    func setupDescriptionScrollView() {
        NSLayoutConstraint.activate([
            descriptionScrollView.topAnchor.constraint(equalTo: contentStackView.bottomAnchor, constant: 20),
            descriptionScrollView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 10),
            descriptionScrollView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            descriptionScrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
        descriptionScrollView.addSubview(descriptionLabel)
        
        NSLayoutConstraint.activate([
            descriptionLabel.topAnchor.constraint(equalTo: descriptionScrollView.topAnchor),
            descriptionLabel.leadingAnchor.constraint(equalTo: descriptionScrollView.leadingAnchor),
            descriptionLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            descriptionLabel.bottomAnchor.constraint(equalTo: descriptionScrollView.bottomAnchor),
        ])
    }
    
    // MARK: - Setup Data
    
    //    func setupData() {
    //        guard let url = selectedUrl else {
    //            return
    //        }
    //        bookDetailViewModel.setUrl(url)
    //        bookDetailViewModel.$loadingDetailCompleted
    //            .receive(on: DispatchQueue.main)
    //            .sink { [weak self] completed in
    //                if completed {
    //                    self?.descriptionLabel.text = self?.bookDetailViewModel.book?.volumeInfo?.description
    //                }
    //            }
    //            .store(in: &cancellables)
    //    }
}

// -MARK: Preview
struct BookDetailsViewControllerPreview: PreviewProvider {
    static var previews: some View {
        VCPreview {
            BookDetailViewController()
        }
    }
}

