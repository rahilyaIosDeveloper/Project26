//
//  AddCell.swift
//  Project26
//
//  Created by Rahilya Nazaralieva on 23/6/24.
//

import Foundation
import UIKit

struct AddCellData {
    var title: String
    var amount: Int
}

class AddCell: UICollectionViewCell {
    
    static var reuseId = "add_cell"
    
    private lazy var titleLabel: UILabel = {
        let view = UILabel()
        view.text = "Shaurma"
        return view
    }()
    
    private lazy var amountLabel: UILabel = {
        let view = UILabel()
        view.textAlignment = .right
        view.text = "200 c."
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupConstraints()
        backgroundColor = .clear
    }
    
    func setup(data: AddCellData) {
        titleLabel.text = data.title
        amountLabel.text = String(data.amount) + "c."
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupConstraints() {
        addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(5)
            make.centerY.equalToSuperview()
        }
        
        addSubview(amountLabel)
        amountLabel.snp.makeConstraints { make in
            make.right.equalToSuperview().offset(-5)
            make.centerY.equalToSuperview()
        }
    }
}
