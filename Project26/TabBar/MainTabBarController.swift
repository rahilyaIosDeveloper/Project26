//
//  MainTabBarController.swift
//  Project26
//
//  Created by Rahilya Nazaralieva on 17/6/24.
//
import UIKit
import SnapKit

class MainTabBarController: UITabBarController {
    
    private lazy var mainTabBar: MainTabBar = {
        let view = MainTabBar()
        view.setup(backgroundColor: .white, images: ["house", "plus.circle", "person"])
        view.layer.cornerRadius = 20
        view.delegate = self
        return view
    }()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        tabBar.isHidden = true
        view.backgroundColor = .systemBackground
        setupConstraints()
        configureViewController()
        
    }

    private func setupConstraints() {
        view.addSubview(mainTabBar)
        mainTabBar.snp.makeConstraints { make in
            make.bottom.equalToSuperview().offset(-30)
            make.left.equalToSuperview().offset(30)
            make.right.equalToSuperview().offset(-30)
            make.height.equalTo(60)
        }
    }
    
    private func configureViewController() {
           let homeView = HomeView()
           homeView.title = "Home"
           let vc1 = UINavigationController(rootViewController: homeView)
           let expendsAddView = ExpensesTabBarController()
           expendsAddView.title = "Expends"
           let vc2 = UINavigationController(rootViewController: expendsAddView)
           let profileView = ProfileView()
           profileView.title = "Profile"
           let vc3 = UINavigationController(rootViewController: profileView)
           
           viewControllers = [vc1, vc2, vc3]
       }
}

extension MainTabBarController: MainTabBarDelegate {
    func didTabButtonTap(tag: Int) {
        selectedIndex = tag
    }
}
