//
//  HomeView.swift
//  Project26
//
//  Created by Rahilya Nazaralieva on 17/6/24.
//
import UIKit
import SnapKit

class HomeView: UIViewController {
    
    
    private lazy var homeBottomView: HomeBottomView = {
        let view = HomeBottomView()
        view.layer.cornerRadius = 30
        view.backgroundColor = .white
        return view
    }()
    
    private lazy var totalAmountLabel = {
        let view = UILabel()
        view.text = "24000 c."
        view.textColor = .white
        view.font = UIFont.systemFont(ofSize: 25, weight: .bold)
        return view
    }()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationItem.hidesBackButton = true
        if UserDefaults.standard.bool(forKey: "theme") == true {
            view.overrideUserInterfaceStyle = .dark
        } else {
            view.overrideUserInterfaceStyle = .light
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.init(red: 28/255, green: 89/255, blue: 255/255, alpha: 1)
        setupConstraints()
    }
    
    
    private func setupConstraints() {
        view.addSubview(homeBottomView)
        homeBottomView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(150)
            make.left.equalToSuperview()
            make.right.equalToSuperview()
            make.bottom.equalToSuperview()
        }
        
        view.addSubview(totalAmountLabel)
        totalAmountLabel.snp.makeConstraints { make in
            make.bottom.equalTo(homeBottomView.snp.top).offset(-100)
            make.centerX.equalToSuperview()
        }
    }
}

