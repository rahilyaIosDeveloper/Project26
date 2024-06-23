//
//  SettingsController.swift
//  Project26
//
//  Created by Rahilya Nazaralieva on 17/6/24.
//

protocol SettingsControllerToViewProtocol: AnyObject {
}

protocol SettingsControllerToModelProtocol: AnyObject {
}


class SettingsController {
    //храним ссылки на view и model
    private weak var view: SettingsViewProtocol?
    private var model: SettingsModelProtocol?
    
    init(view: SettingsViewProtocol) {
        self.view = view //+2
        self.model = SettingsModel(controller: self)
    }
    
    deinit {
        print("SettingsController is deinitialized")
    }
}

extension SettingsController: SettingsControllerToModelProtocol {    
}

extension SettingsController: SettingsControllerToViewProtocol {
}

