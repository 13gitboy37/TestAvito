//
//  MainViewPresenter.swift
//  AvitoTest
//
//  Created by Никита Мошенцев on 08.11.2022.
//

import Foundation


//MARK: - MainViewOutput

protocol MainViewOutput: AnyObject {
    func getEmployees()
    func checkNetworkConnection()
}

final class MainViewPresenter {
    
    //MARK: Properties
    
    weak var view: MainViewInput?
    
    let storageService: StorageServiceProtocol?
    
    //MARK: - Init
    
    init(storageService: StorageServiceProtocol) {
        self.storageService = storageService
    }
}

//MARK: - Release MainViewOutput

extension MainViewPresenter: MainViewOutput {
    func getEmployees() {
        storageService?.getEmployees { [weak self] employees in
            self?.view?.reloadTable(withEmployees: employees)
        }
    }
    
    func checkNetworkConnection() {
        if !NetworkMonitor.shared.isConnected {
            self.view?.configureNotConnectionView()
        } else {
            self.view?.configureConnectionView()
        }
        getEmployees()
    }
}
