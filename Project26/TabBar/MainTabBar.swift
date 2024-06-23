//
//  MainTabBarController.swift
//  Project26
//
//  Created by Rahilya Nazaralieva on 17/6/24.
//

import UIKit

protocol MainTabBarDelegate:  AnyObject {
    func didTabButtonTap(tag: Int)
}

class MainTabBar: UIView {
    
    private var images: [String] = []
    
    weak var delegate: MainTabBarDelegate?
    
    private lazy var stackView: UIStackView = {
        let view = UIStackView()
        view.axis = .horizontal
        view.spacing = 10
        view.alignment = .center
        view.distribution = .fillEqually
        view.layer.cornerRadius = 20
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(stackView)
        setupConstraints()
    }
    
    
    func setup(backgroundColor: UIColor, images: [String]) {
        self.images = images
        self.backgroundColor = backgroundColor
        for i in 0...images.count - 1 {
            let button = createButton(image: images[i])
            button.tag = i
            button.addTarget(self, action: #selector(tabButtonTapped), for: .touchUpInside)
            stackView.addArrangedSubview(button)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func tabButtonTapped(sender: UIButton) {
        delegate?.didTabButtonTap(tag: sender.tag)
    }
    
    private func setupConstraints() {
            stackView.snp.makeConstraints { make in
                make.edges.equalToSuperview().inset(10)
            }
        }
    
    func createButton(image: String) -> UIButton {
        let view = UIButton(type: .system)
        view.setImage(UIImage(systemName: image), for: .normal)
        view.tintColor = .systemBlue
        return view
    }
}
