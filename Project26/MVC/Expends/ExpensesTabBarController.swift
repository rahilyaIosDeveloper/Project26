//
//  ExpensesTabBarController.swift
//  Project26
//
//  Created by Rahilya Nazaralieva on 20/6/24.
//
import UIKit

protocol ExpendsTabBarControllerDelegate: AnyObject {
    func didAddTap()
}

class ExpensesTabBarController: UITabBarController {
    
    private var expensesView = ExpensesView()
    
    private var incomesView = IncomesView()
    
    weak var expendsTabBarControllerDelegate: ExpendsTabBarControllerDelegate?
    
    private lazy var pageSegmentControl: UISegmentedControl = {
        let items = ["Расходы", "Доходы"]
        let view = UISegmentedControl(items: items)
        view.setTitle(items[0], forSegmentAt: 0)
        view.setTitle(items[1], forSegmentAt: 1)
        view.addTarget(self, action: #selector(segmentControlValueChanged), for: .valueChanged)
        view.backgroundColor = .lightGray
        view.selectedSegmentTintColor = .systemBlue
        return view
    }()
    
    private lazy var addButton: UIButton = {
        let view = UIButton(type: .system)
        view.setTitle("+", for: .normal)
        view.setTitleColor(.white, for: .normal)
        view.backgroundColor = .systemBlue
        view.layer.cornerRadius = 60 / 2
        view.addTarget(self, action: #selector(addButtonTapped), for: .touchUpInside)
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        expensesView.expendsTabBarController = self
        viewControllers = [expensesView, incomesView]
        setupConstraints()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tabBar.isHidden = true
    }
    
    @objc func segmentControlValueChanged() {
        if pageSegmentControl.selectedSegmentIndex == 0 {
            selectedIndex = 0
        } else {
            selectedIndex = 1
        }
    }
    
    @objc func addButtonTapped() {
        expendsTabBarControllerDelegate?.didAddTap()
    }
    
    private func setupConstraints() {
        view.addSubview(pageSegmentControl)
        pageSegmentControl.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(200)
            make.left.equalTo(view.snp.left).offset(15)
            make.right.equalTo(view.snp.right).offset(-15)
            make.height.equalTo(44)
        }
        
        view.addSubview(addButton)
        addButton.snp.makeConstraints { make in
            make.bottom.equalTo(view.snp.bottom).offset(-150)
            make.right.equalTo(view.snp.right).offset(-30)
            make.height.equalTo(60)
            make.width.equalTo(60)
        }
    }
}
