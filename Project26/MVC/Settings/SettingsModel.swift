//
//  SettingsModel.swift
//  Project26
//
//  Created by Rahilya Nazaralieva on 17/6/24.
//

protocol SettingsModelProtocol: AnyObject {
}

class SettingsModel: SettingsModelProtocol {
    //храним взаимную ссылку на контроллер
    private weak var controller: SettingsControllerToModelProtocol?
    
    init(controller: SettingsControllerToModelProtocol) {
        self.controller = controller
    }
    
    deinit {
        print("SettingsModel is deinitialized")
    }
}

