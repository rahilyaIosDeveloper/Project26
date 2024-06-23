//
//  ProfileView.swift
//  Project26
//
//  Created by Rahilya Nazaralieva on 17/6/24.
//

import UIKit

class ProfileView: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemPink
        setupNavigationItem()
    }
    
    private func setupNavigationItem() {
        let settingsButton = UIBarButtonItem(image: UIImage(systemName: "gear"), style: .plain, target: self, action: #selector(settingsButtonTapped))
        navigationItem.rightBarButtonItem = settingsButton
    }
    
    @objc func settingsButtonTapped() {
        let settingsView = SettingsView()
        navigationController?.pushViewController(settingsView, animated: true)
    }
    
    deinit {
        print("ProfileView is deinitialized")
    }
}

