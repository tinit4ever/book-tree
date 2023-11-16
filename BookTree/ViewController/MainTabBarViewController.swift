//
//  MainTabBarViewController.swift
//  BookTree
//
//  Created by Nguyen Trung Tin on 16/11/2023.
//

import UIKit
import SwiftUI
class MainTabBarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    func setupUI() {
        view.backgroundColor = .black
        
        let homeViewController = HomeViewController()
        let homeNavagationController = UINavigationController(rootViewController: homeViewController)
        
        let bookSearchViewController = BookSearchViewController(bookSearchViewModel: BookSearchViewModel(apiCaller: APICaller()))
        let bookSearchNavagationController = UINavigationController(rootViewController: bookSearchViewController)
        
        homeNavagationController.tabBarItem.image = UIImage(systemName: "book.closed.fill")
        bookSearchNavagationController.tabBarItem.image = UIImage(systemName: "magnifyingglass")
        
        homeNavagationController.title = "Home"
        bookSearchNavagationController.title = "Search"
        
        setViewControllers([bookSearchNavagationController, homeNavagationController], animated: true)
    }
}

// -MARK: Preview
struct MainViewControllerPreview: PreviewProvider {
    static var previews: some View {
        VCPreview {
            let mainViewController = MainTabBarViewController()
            return mainViewController
        }
    }
}

