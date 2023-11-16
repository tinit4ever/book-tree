//
//  BookTableViewCell.swift
//  BookTree
//
//  Created by Nguyen Trung Tin on 16/11/2023.
//

import UIKit
import SDWebImage

class BookTableViewCell: UITableViewCell {
    static let identifier: String = "BookTableViewCell"
    
    lazy var itemStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 10
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()

    lazy var contentStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .leading
        stackView.spacing = 10
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    lazy var itemImageView: UIImageView = {
        let imageView = UIImageView(frame: .zero)
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 10
        imageView.backgroundColor = .black
        imageView.layer.borderWidth = 1
        imageView.layer.borderColor = UIColor.black.cgColor
        imageView.clipsToBounds = true
        imageView.image = UIImage(named: "NAImage")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 2
        label.textAlignment = .left
        label.font = UIFont(name: "Arial Rounded MT Bold", size: 18)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var authorLabel: UILabel = {
        let label = UILabel()
        label.textColor = .gray
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 2
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var rateStack: UIStackView = {
        let stackView = UIStackView()
        stackView.spacing = 5
        stackView.addArrangedSubview(rateLabel)
        stackView.addArrangedSubview(starImageView)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    lazy var rateLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var starImageView: UIImageView = {
        let imageView = UIImageView()
        let image = UIImage(systemName: "star.fill")?.withRenderingMode(.alwaysTemplate)
        imageView.image = image
        imageView.tintColor = .systemYellow
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    lazy var categoriesLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    func setupUI() {
        itemStackView.addArrangedSubview(itemImageView)
        itemStackView.addArrangedSubview(contentStackView)
        contentStackView.addArrangedSubview(titleLabel)
        contentStackView.addArrangedSubview(authorLabel)
        contentStackView.addArrangedSubview(rateStack)
        contentStackView.addArrangedSubview(categoriesLabel)
        contentView.addSubview(itemStackView)
        setupItemStackView()
    }
    
    func setupItemStackView() {
        NSLayoutConstraint.activate([
            itemStackView.topAnchor.constraint(equalTo: contentView.topAnchor),
            itemStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            itemStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            itemStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            itemImageView.widthAnchor.constraint(equalToConstant: 110),
        ])
        
    }
    
    func configure(book: BookAPI) {
        if let urlString = book.volumeInfo?.imageLinks?.thumbnail {
            itemImageView.sd_setImage(with: URL(string: urlString))
        }
        titleLabel.text = book.volumeInfo?.title ?? "Unknow"
        authorLabel.text = "By: \(book.volumeInfo?.authors?.joined(separator: ",") ?? "Unknow")"
        rateLabel.text = String(book.volumeInfo?.averageRating ?? 0)
        categoriesLabel.text = book.volumeInfo?.categories?.joined(separator: ",") ?? ""
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10))
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
