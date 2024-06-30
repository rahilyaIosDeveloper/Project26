////
////  SettingsView.swift
////  Project26
////
////  Created by Rahilya Nazaralieva on 17/6/24.
////
///
//ARC - Automatic Reference Counting (Автоматический подсчет ссылок)
//strong - cильная ссылка
//weak - cлабая ссылка (можно ссылку оставить опциональной) прибавляет + 1
//unowned - cлабая ссылка (обязательно проинициализировать) прибавляет + 1
import UIKit

protocol SettingsViewProtocol: AnyObject {
}

class SettingsView: UIViewController {
    private var controller: SettingsControllerToViewProtocol?

    private var settings: [Settings] = [Settings(image: "language", title: "Выбрать язык", type: .descritpion, description: "русский"), Settings(image: "moon", title: "Темная тема", type: .withSwitch), Settings(image: "trash", title: "Очистить данные", type: .standart)]

    private lazy var settingsTableView: UITableView = {
        let view = UITableView()
        view.register(SettingsCell.self, forCellReuseIdentifier: SettingsCell.reuseId)
        view.dataSource = self
        view.delegate = self
        view.backgroundColor = .lightGray
        view.layer.cornerRadius = 10
        return view
    }()

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        updateNavigationBarAppearance()
        
    }

    func updateNavigationBarAppearance() {
        let isDarkTheme = UserDefaults.standard.bool(forKey: "theme")
        let appearance = UINavigationBarAppearance()

        if isDarkTheme {
            view.overrideUserInterfaceStyle = .dark
            navigationController?.navigationBar.barTintColor = .black
            appearance.titleTextAttributes = [.foregroundColor: UIColor.white]
        } else {
            view.overrideUserInterfaceStyle = .light
            navigationController?.navigationBar.barTintColor = .white
            appearance.titleTextAttributes = [.foregroundColor: UIColor.black]
        }

        navigationItem.standardAppearance = appearance
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Settings"
        view.backgroundColor = .systemBackground
        controller = SettingsController(view: self)
        setupConstraints()

        let isDarkTheme = UserDefaults.standard.bool(forKey: "theme")
        if isDarkTheme == true {
            view.overrideUserInterfaceStyle = .dark
        } else {
            view.overrideUserInterfaceStyle = .light
        }

        NotificationCenter.default.addObserver(self, selector: #selector(updateTheme), name: UserDefaults.didChangeNotification, object: nil)
    }

    @objc func updateTheme() {
        updateNavigationBarAppearance()
        view.overrideUserInterfaceStyle = UserDefaults.standard.bool(forKey: "theme") ? .dark : .light
    }

    deinit {
        NotificationCenter.default.removeObserver(self, name: UserDefaults.didChangeNotification, object: nil)
    }

    private func setupConstraints() {
        view.addSubview(settingsTableView)
        settingsTableView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.left.equalToSuperview()
            make.right.equalToSuperview()
            make.height.equalTo(156)
        }
    }
}

extension SettingsView: SettingsViewProtocol {
}

extension SettingsView: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return settings.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: SettingsCell.reuseId, for: indexPath) as! SettingsCell
        let item = settings[indexPath.row]
        cell.setup(settings: item)
        cell.delegate = self
        return cell
    }
}

extension SettingsView: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 55
    }
}

extension SettingsView: SettingsCellDelegate {
    func didSwitch(isOn: Bool) {
        UserDefaults.standard.setValue(isOn, forKey: "theme")
        NotificationCenter.default.post(name: UserDefaults.didChangeNotification, object: nil)
    }
}
