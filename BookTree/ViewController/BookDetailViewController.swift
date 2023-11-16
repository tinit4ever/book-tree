//
//  BookDetailViewController.swift
//  BookTree
//
//  Created by Nguyen Trung Tin on 14/11/2023.
//

import UIKit
import SwiftUI
import Combine
import SDWebImage

class BookDetailViewController: UIViewController {
    var book: BookAPI?
    var imageViewHeightConstraint: NSLayoutConstraint!
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
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 10
        imageView.backgroundColor = .black
        imageView.layer.borderWidth = 2
        imageView.layer.borderColor = UIColor.black.cgColor
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.text = "Title"
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 0
        label.textAlignment = .center
        label.font = UIFont(name: "Arial Rounded MT Bold", size: 24)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var authorLabel: UILabel = {
        let label = UILabel()
        label.textColor = .gray
        label.text = "Author"
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 0
        label.textAlignment = .center
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
        label.text = "Pages"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var pageCountContentLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = UIFont(name: "Arial Rounded MT Bold", size: 22)
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
        label.font = UIFont(name: "Arial Rounded MT Bold", size: 22)
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
        label.font = UIFont(name: "Arial Rounded MT Bold", size: 22)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var descriptionScrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.isScrollEnabled = true
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.showsVerticalScrollIndicator = true
        scrollView.layer.cornerRadius = 20
        scrollView.backgroundColor = .systemGray6
        scrollView.delegate = self
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
    
    lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 0
        label.font = UIFont(name: "Chalkboard SE", size: 22)
        label.text = "Sure, here is a one-paragraph summary of The 7 Habits of Highly Effective People: To achieve personal and professional success, Stephen R. Covey advocates for adopting seven key principles: proactive responsibility for one's life, starting with a clear vision of goals, prioritizing tasks based on importance, seeking mutually beneficial solutions, listening empathetically before communicating, valuing others' strengths for collaboration, and continuous self-improvement in all aspects of life. Sure, here is a one-paragraph summary of The 7 Habits of Highly Effective People: To achieve personal and professional success, Stephen R. Covey advocates for adopting seven key principles: proactive responsibility for one's life, starting with a clear vision of goals, prioritizing tasks based on importance, seeking mutually beneficial solutions, listening empathetically before communicating, valuing others' strengths for collaboration, and continuous self-improvement in all aspects of life. Sure, here is a one-paragraph summary of The 7 Habits of Highly Effective People: To achieve personal and professional success, Stephen R. Covey advocates for adopting seven key principles: proactive responsibility for one's life, starting with a clear vision of goals, prioritizing tasks based on importance, seeking mutually beneficial solutions, listening empathetically before communicating, valuing others' strengths for collaboration, and continuous self-improvement in all aspects of life"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var dividerView: UIView = {
        let view = UIView()
        view.backgroundColor = .gray
        view.translatesAutoresizingMaskIntoConstraints = false
        view.widthAnchor.constraint(equalToConstant: 1).isActive = true
        return view
    }()
    
    lazy var secondDividerView: UIView = {
        let view = UIView()
        view.backgroundColor = .gray
        view.translatesAutoresizingMaskIntoConstraints = false
        view.widthAnchor.constraint(equalToConstant: 1).isActive = true
        return view
    }()
    
    // MARK: - Did Load
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupData()
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
        setupTitleAndAuthorLabel()
        
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
            //            imageView.heightAnchor.constraint(equalToConstant: 182),
            imageView.widthAnchor.constraint(equalToConstant: 120),
        ])
        imageViewHeightConstraint = imageView.heightAnchor.constraint(equalToConstant: 182)
        imageViewHeightConstraint.isActive = true
    }
    
    func setupTitleAndAuthorLabel() {
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: stackView.leadingAnchor, constant: 20),
            titleLabel.trailingAnchor.constraint(equalTo: stackView.trailingAnchor, constant: -20),
            authorLabel.leadingAnchor.constraint(equalTo: stackView.leadingAnchor, constant: 20),
            authorLabel.trailingAnchor.constraint(equalTo: stackView.trailingAnchor, constant: -20)
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
            contentStackView.heightAnchor.constraint(equalToConstant: 50),
            languageStack.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }
    
    func setupDescriptionScrollView() {
        NSLayoutConstraint.activate([
            descriptionScrollView.topAnchor.constraint(equalTo: contentStackView.bottomAnchor, constant: 20),
            descriptionScrollView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            descriptionScrollView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            descriptionScrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        descriptionScrollView.addSubview(descriptionLabel)
        
        NSLayoutConstraint.activate([
            descriptionLabel.topAnchor.constraint(equalTo: descriptionScrollView.topAnchor, constant: 10),
            descriptionLabel.leadingAnchor.constraint(equalTo: descriptionScrollView.leadingAnchor, constant: 20),
            descriptionLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            descriptionLabel.bottomAnchor.constraint(equalTo: descriptionScrollView.bottomAnchor),
        ])
    }
    
    //     MARK: - Setup Data
    func setupData() {
        if let url = URL(string: (book?.volumeInfo?.imageLinks!.thumbnail) ?? "") {
            imageView.sd_setImage(with: url)
        } else {
            imageView.image = UIImage(named: "NAImage")
        }
        titleLabel.text = book?.volumeInfo?.title ?? "N/A"
        authorLabel.text = book?.volumeInfo?.authors?.joined(separator: ",") ?? "N/A"
        pageCountContentLabel.text = String(book?.volumeInfo?.pageCount ?? 0)
        languageContentLabel.text = book?.volumeInfo?.language?.uppercased() ?? "N/A"
        
        let releaseDateString: String = book?.volumeInfo?.publishedDate ?? "N/A"
        releaseContentLabel.text = String(releaseDateString.prefix(4))
        descriptionLabel.text = book?.volumeInfo?.description ?? "N/A"
    }
}

extension BookDetailViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offset = scrollView.contentOffset.y
        
        let minHeight: CGFloat = 0
        let maxHeight: CGFloat = 182
        
        var newHeight = maxHeight - offset
        newHeight = max(minHeight, newHeight)
        
        imageViewHeightConstraint.isActive = false
        
        imageViewHeightConstraint = imageView.heightAnchor.constraint(equalToConstant: newHeight)
        imageViewHeightConstraint.isActive = true
        
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
            let offset = scrollView.contentOffset.y
            let contentHeight = scrollView.contentSize.height
            let scrollViewHeight = scrollView.frame.size.height

            if offset <= 0 {
                handleScrollToTop()
            } else if offset >= contentHeight - scrollViewHeight {
                handleScrollToBottom()
            }
        }

        func handleScrollToTop() {
            imageViewHeightConstraint.isActive = false
            
            imageViewHeightConstraint = imageView.heightAnchor.constraint(equalToConstant: 182)
            imageViewHeightConstraint.isActive = true
        }

        func handleScrollToBottom() {
            imageViewHeightConstraint.isActive = false
            
            imageViewHeightConstraint = imageView.heightAnchor.constraint(equalToConstant: 0)
            imageViewHeightConstraint.isActive = true
        }
}

// -MARK: Preview
struct BookDetailsViewControllerPreview: PreviewProvider {
    static var previews: some View {
        VCPreview {
            let bookDetailViewController = BookDetailViewController()
            return bookDetailViewController
        }
    }
}

