//
//  SettingsCell.swift
//  Project26
//
//  Created by Rahilya Nazaralieva on 17/6/24.
//

import UIKit
import SnapKit

enum SettingsType {
    case standart
    case withSwitch
    case descritpion
}

struct Settings {
    var image: String
    var title: String
    var type: SettingsType
    var description: String?
}

protocol SettingsCellDelegate: AnyObject {
    func didSwitch(isOn: Bool)
}

class SettingsCell: UITableViewCell {
    static var reuseId = "settings_cell"
    
    weak var delegate: SettingsCellDelegate?
    
    private lazy var leftImageView: UIImageView = {
        let view = UIImageView()
        view.tintColor = .black
        return view
    }()
    
    private lazy var titleLabel: UILabel = {
        let view = UILabel()
        return view
    }()
    
    private lazy var switchView: UISwitch = {
        let view = UISwitch()
        view.addTarget(self, action: #selector(switchValueChanged), for: .valueChanged)
        return view
    }()
    
    private lazy var buttonTable: UIButton = {
        let view = UIButton()
        view.setImage(
            UIImage(systemName: "chevron.compact.right"),
            for: .normal)
        view.tintColor = .label
//        view.addTarget(self, action: #selector(buttonTableTapped(sender:)), for: .touchUpInside)
        return view
    }()
    
    private lazy var lableLanguage: UILabel = {
        let view = UILabel()
        return view
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.backgroundColor = .secondarySystemBackground
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func switchValueChanged() {
        delegate?.didSwitch(isOn: switchView.isOn)
    }
    
    func setup(settings: Settings) {
            leftImageView.image = UIImage(named: settings.image)
            titleLabel.text = settings.title
            lableLanguage.text = settings.description
            lableLanguage.font = UIFont.systemFont(ofSize: 17)
            
            switch settings.type {
            case .standart:
                switchView.isHidden = true
                lableLanguage.isHidden = true
                buttonTable.isHidden = true
            case .withSwitch:
                switchView.isHidden = false
                lableLanguage.isHidden = true
                buttonTable.isHidden = true
            case .descritpion:
                switchView.isHidden = true
                lableLanguage.isHidden = false
                buttonTable.isHidden = false
            }
        }
    
    private func setupConstraints() {
        addSubview(leftImageView)
        leftImageView.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(16)
            make.centerY.equalToSuperview()
            make.height.width.equalTo(24)
        }

        contentView.addSubview(switchView)
        switchView.snp.makeConstraints { make in
            make.right.equalToSuperview().offset(-16)
            make.centerY.equalToSuperview()
        }

        addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.left.equalTo(leftImageView.snp.right).offset(13)
            make.right.equalTo(switchView.snp.left).offset(-13)
            make.centerY.equalToSuperview()
        }
        
        addSubview(lableLanguage)
        lableLanguage.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.trailing.equalTo(-35)
        }
        contentView.addSubview(buttonTable)
        buttonTable.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.height.equalTo(13.8)
            make.width.equalTo(8)
            make.trailing.equalTo(-16)
        }
    }
}
