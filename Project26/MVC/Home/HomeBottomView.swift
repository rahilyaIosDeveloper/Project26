////
////  HomeBottomView.swift
////  Project26
////
////  Created by Rahilya Nazaralieva on 23/6/24.
////
//
import UIKit

class HomeBottomView: UIView {
    var discription: [String] = ["Flowers", "Cosmetics", "Taxi", "Food", "Education", "Credit", "Shopping"]
    let discriptionImage: [String] = ["flowers", "cosmetics", "taxi", "food", "education", "credit", "shopping"]

    var discriptionVer: [String] = ["Flowers", "Cosmetics", "Taxi", "Food", "Education", "Credit", "Shopping"]
    let discriptionImageVer: [String] = ["flowers", "cosmetics", "taxi", "food", "education", "credit", "shopping"]
    let expenses: [String] = ["-1277c", "-5000c", "249c", "890c", "13000", "25000c", "3490c"]

    private lazy var horizontalCollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let view = UICollectionView(frame: .zero, collectionViewLayout: layout)
        view.dataSource = self
        view.delegate = self
        view.register(A.self, forCellWithReuseIdentifier: A.reuseId)
        return view
    }()

    private lazy var verticalCollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let view = UICollectionView(frame: .zero, collectionViewLayout: layout)
        view.dataSource = self
        view.delegate = self
        view.register(B.self, forCellWithReuseIdentifier: B.reuseId)
        return view
    }()

    private lazy var horizontalLabel: UILabel = {
        let label = UILabel()
        label.text = "Spending"
        label.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        return label
    }()

    private lazy var verticalLabel: UILabel = {
        let label = UILabel()
        label.text = "Analysis"
        label.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        return label
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupConstraints()
        updateColors()
        NotificationCenter.default.addObserver(self, selector: #selector(updateColors), name: UserDefaults.didChangeNotification, object: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupConstraints() {
        addSubview(horizontalCollectionView)
        addSubview(verticalCollectionView)
        addSubview(horizontalLabel)
        addSubview(verticalLabel)

        horizontalLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(30)
            make.left.equalToSuperview().offset(13)
        }

        horizontalCollectionView.snp.makeConstraints { make in
            make.top.equalTo(horizontalLabel.snp.bottom).offset(3)
            make.left.equalToSuperview().offset(0)
            make.right.equalToSuperview().offset(0)
            make.height.equalTo(160)
        }

        verticalLabel.snp.makeConstraints { make in
            make.top.equalTo(horizontalCollectionView.snp.bottom).offset(40)
            make.left.equalToSuperview().offset(8)
        }

        verticalCollectionView.snp.makeConstraints { make in
            make.top.equalTo(verticalLabel.snp.bottom).offset(10)
            make.left.equalToSuperview().offset(0)
            make.right.equalToSuperview().offset(0)
            make.bottom.equalToSuperview().offset(0)
        }
    }

    @objc func updateColors() {
        let isDarkTheme = UserDefaults.standard.bool(forKey: "theme")

        if isDarkTheme {
            horizontalLabel.textColor = .white
            verticalLabel.textColor = .white
            backgroundColor = .black
        } else {
            horizontalLabel.textColor = .black
            verticalLabel.textColor = .black
            backgroundColor = .white
        }

        horizontalCollectionView.reloadData()
        verticalCollectionView.reloadData()
    }

    deinit {
        NotificationCenter.default.removeObserver(self, name: UserDefaults.didChangeNotification, object: nil)
    }
}

extension HomeBottomView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == horizontalCollectionView {
            return discription.count
        } else {
            return 7
        }
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == horizontalCollectionView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: A.reuseId, for: indexPath) as! A
            cell.mainTextLabel.text = discription[indexPath.item]
            cell.mainImage.image = UIImage(named: discriptionImage[indexPath.item])
            cell.setupSelf(height: (frame.width - 100) / 3)
            cell.updateColors() // Обновите цвета ячейки
            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: B.reuseId, for: indexPath) as! B
            cell.mainTextLabelVer.text = discriptionVer[indexPath.item]
            cell.mainImageVer.image = UIImage(named: discriptionImageVer[indexPath.item])
            cell.expensesLabelVer.text = expenses[indexPath.item]
            cell.updateColors()
            return cell
        }
    }
}

extension HomeBottomView: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == horizontalCollectionView {
            return CGSize(width: (frame.width - 100) / 3, height: (frame.width - 100) / 3)
        } else {
            return CGSize(width: frame.width, height: 100)
        }
    }
}

class A: UICollectionViewCell {
    static var reuseId = "hor_cell"

    private lazy var containerView: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        return view
    }()

    lazy var mainTextLabel: UILabel = {
        let view = UILabel()
        view.textColor = .black
        view.textAlignment = .center
        view.font = UIFont.systemFont(ofSize: 16)
        return view
    }()

    lazy var mainImage: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFit
        return view
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        self.layer.cornerRadius = self.frame.width / 2
    }

    func setupSelf(height: CGFloat) {
        containerView.backgroundColor = UIColor.init(red: 28/255, green: 89/255, blue: 255/255, alpha: 1)
        containerView.layer.cornerRadius = height / 2

        self.addSubview(containerView)
        containerView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.left.equalToSuperview()
            make.right.equalToSuperview()
            make.height.equalTo(height)
        }

        self.addSubview(mainTextLabel)
        mainTextLabel.snp.makeConstraints { make in
            make.top.equalTo(containerView.snp.bottom).offset(10)
            make.left.equalToSuperview()
            make.right.equalToSuperview()
        }

        containerView.addSubview(mainImage)
        mainImage.snp.makeConstraints { make in
            make.height.equalTo(60)
            make.width.equalTo(60)
            make.centerX.equalTo(containerView.snp.centerX)
            make.centerY.equalTo(containerView.snp.centerY)
        }

        updateColors()
    }

    func updateColors() {
        let isDarkTheme = UserDefaults.standard.bool(forKey: "theme")

        if isDarkTheme {
            mainTextLabel.textColor = .white
            containerView.backgroundColor = .black
        } else {
            mainTextLabel.textColor = .black
            containerView.backgroundColor = UIColor.init(red: 28/255, green: 89/255, blue: 255/255, alpha: 1)
        }
    }
}

class B: UICollectionViewCell {
    static var reuseId = "ver_cell"

    private lazy var containerView: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        return view
    }()

    lazy var mainTextLabelVer: UILabel = {
        let view = UILabel()
        view.textColor = .black
        view.textAlignment = .center
        view.font = UIFont.systemFont(ofSize: 16)
        return view
    }()

    lazy var mainImageVer: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFit
        return view
    }()

    lazy var expensesLabelVer: UILabel = {
        let view = UILabel()
        view.textColor = .black
        view.textAlignment = .left
        view.font = UIFont.systemFont(ofSize: 16)
        return view
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setupViews() {
        addSubview(containerView)
        containerView.addSubview(mainImageVer)
        containerView.addSubview(mainTextLabelVer)
        containerView.addSubview(expensesLabelVer)
        containerView.backgroundColor = UIColor(red: 28/255, green: 89/255, blue: 255/255, alpha: 1)

        containerView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.left.equalToSuperview()
            make.right.equalToSuperview()
            make.height.equalTo(100)
        }

        mainImageVer.snp.makeConstraints { make in
            make.leading.equalTo(containerView.snp.leading).offset(10)
            make.centerY.equalTo(containerView.snp.centerY)
            make.height.equalTo(60)
            make.width.equalTo(60)
        }

        mainTextLabelVer.snp.makeConstraints { make in
            make.centerY.equalTo(containerView.snp.centerY)
            make.leading.equalTo(mainImageVer.snp.trailing).offset(7)
            make.trailing.equalTo(expensesLabelVer.snp.leading).offset(-5)
        }

        expensesLabelVer.snp.makeConstraints { make in
            make.centerY.equalTo(containerView.snp.centerY)
            make.trailing.equalTo(containerView.snp.trailing).offset(-10)
        }

        updateColors()
    }

    func updateColors() {
        let isDarkTheme = UserDefaults.standard.bool(forKey: "theme")

        if isDarkTheme {
            mainTextLabelVer.textColor = .white
            expensesLabelVer.textColor = .white
            containerView.backgroundColor = .black
        } else {
            mainTextLabelVer.textColor = .black
            expensesLabelVer.textColor = .black
            containerView.backgroundColor = UIColor.init(red: 28/255, green: 89/255, blue: 255/255, alpha: 1)
        }
    }
}
