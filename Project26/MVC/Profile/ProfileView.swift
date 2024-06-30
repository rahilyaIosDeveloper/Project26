//
//  ProfileView.swift
//  Project26
//
//  Created by Rahilya Nazaralieva on 17/6/24.
//

import UIKit

class ProfileView: UIViewController {
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if UserDefaults.standard.bool(forKey: "theme") == true {
            view.overrideUserInterfaceStyle = .dark
        } else {
            view.overrideUserInterfaceStyle = .light
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
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

