////
////  ExpensesView.swift
////  Project26
////
////  Created by Rahilya Nazaralieva on 20/6/24.
////
//
//import UIKit
//
//class ExpensesView: UIViewController {
//    
//    var dataList: [AddCellData] = []
//    
//    var expendsTabBarController: ExpensesTabBarController?
//    
//    lazy var expensesCollectionView: UICollectionView = {
//        let layout = UICollectionViewFlowLayout()
//        let view = UICollectionView(frame: .zero, collectionViewLayout: layout)
//        view.register(AddCell.self, forCellWithReuseIdentifier: AddCell.reuseId)
//        view.dataSource = self
//        view.delegate = self
//        view.backgroundColor = .clear
//        return view
//    }()
//    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        view.backgroundColor = .cyan
//        expendsTabBarController?.expendsTabBarControllerDelegate = self
//        setupConstraints()
//    }
//    
//    override func viewWillAppear(_ animated: Bool) {
//        super.viewWillAppear(animated)
//        if UserDefaults.standard.bool(forKey: "theme") == true {
//            view.overrideUserInterfaceStyle = .dark
//        } else {
//            view.overrideUserInterfaceStyle = .light
//        }
//        expensesCollectionView.reloadData()
//    }
//    
//    private func setupConstraints() {
//        view.addSubview(expensesCollectionView)
//        expensesCollectionView.snp.makeConstraints { make in
//            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(244)
//            make.left.equalTo(view.snp.left).offset(10)
//            make.right.equalTo(view.snp.right).offset(-10)
//            make.bottom.equalTo(view.snp.bottom)
//        }
//    }
//}
//
//extension ExpensesView: UICollectionViewDataSource {
//    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        return dataList.count
//    }
//    
//    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: AddCell.reuseId, for: indexPath) as! AddCell
//        let item = dataList[indexPath.row]
//        cell.setup(data: item)
//        return cell
//    }
//    
//    
//}
//
//extension ExpensesView: UICollectionViewDelegateFlowLayout {
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        return CGSize(width: collectionView.frame.width, height: 50)
//    }
//}
//
//extension ExpensesView: ExpendsTabBarControllerDelegate {
//    func didAddTap() {
//        let alert = UIAlertController(title: "Расходы", message: "Добавьте расходы", preferredStyle: .alert)
//        var amounTextField = UITextField()
//        var titleTextField = UITextField()
//        
//        let acceptAction = UIAlertAction(title: "Да", style: .cancel) { action in
//            self.dataList.append(AddCellData(title: titleTextField.text ?? "", amount: Int(amounTextField.text ?? "0") ?? 0))
//            self.expensesCollectionView.reloadData()
//            print(self.dataList)
//        }
//        
//        let declineAction = UIAlertAction(title: "Нет", style: .default) { action in
//            
//        }
//        
//        alert.addTextField { textField in
//            amounTextField = textField
//            
//        }
//        alert.addTextField { textField in
//            titleTextField = textField
//        }
//        
//        alert.addAction(acceptAction)
//        alert.addAction(declineAction)
//        present(alert, animated: true)
//    }
//}



import UIKit

class ExpensesView: UIViewController {
    
    var dataList: [AddCellData] = []
    
    var expendsTabBarController: ExpensesTabBarController?
    
    lazy var expensesCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let view = UICollectionView(frame: .zero, collectionViewLayout: layout)
        view.register(AddCell.self, forCellWithReuseIdentifier: AddCell.reuseId)
        view.dataSource = self
        view.delegate = self
        view.backgroundColor = .clear
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        expendsTabBarController?.expendsTabBarControllerDelegate = self
        setupConstraints()
        
        NotificationCenter.default.addObserver(self, selector: #selector(updateTheme), name: UserDefaults.didChangeNotification, object: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        updateTheme()
        expensesCollectionView.reloadData()
    }
    
    @objc private func updateTheme() {
        let isDarkTheme = UserDefaults.standard.bool(forKey: "theme")
        view.overrideUserInterfaceStyle = isDarkTheme ? .dark : .light
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self, name: UserDefaults.didChangeNotification, object: nil)
    }
    
    private func setupConstraints() {
        view.addSubview(expensesCollectionView)
        expensesCollectionView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(244)
            make.left.equalTo(view.snp.left).offset(10)
            make.right.equalTo(view.snp.right).offset(-10)
            make.bottom.equalTo(view.snp.bottom)
        }
    }
}

extension ExpensesView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: AddCell.reuseId, for: indexPath) as! AddCell
        let item = dataList[indexPath.row]
        cell.setup(data: item)
        return cell
    }
}

extension ExpensesView: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: 50)
    }
}

extension ExpensesView: ExpendsTabBarControllerDelegate {
    func didAddTap() {
        let alert = UIAlertController(title: "Расходы", message: "Добавьте расходы", preferredStyle: .alert)
        var amountTextField = UITextField()
        var titleTextField = UITextField()
        
        let acceptAction = UIAlertAction(title: "Да", style: .default) { action in
            self.dataList.append(AddCellData(title: titleTextField.text ?? "", amount: Int(amountTextField.text ?? "0") ?? 0))
            self.expensesCollectionView.reloadData()
        }
        
        let declineAction = UIAlertAction(title: "Нет", style: .cancel, handler: nil)
        
        alert.addTextField { textField in
            amountTextField = textField
            textField.placeholder = "Введите сумму"
        }
        
        alert.addTextField { textField in
            titleTextField = textField
            textField.placeholder = "Введите название"
        }
        
        alert.addAction(acceptAction)
        alert.addAction(declineAction)
        present(alert, animated: true, completion: nil)
    }
}
