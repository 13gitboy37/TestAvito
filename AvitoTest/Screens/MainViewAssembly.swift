//
//  MainViewAssembly.swift
//  AvitoTest
//
//  Created by Никита Мошенцев on 08.11.2022.
//

import Foundation

final class MainViewAssembly {
    func assemble() -> MainViewController {
        
        let networkService = NetworkService()
        let storageService = StorageService(networkService: networkService)
        let presenter = MainViewPresenter(storageService: storageService)
        let tableAdapter = MainTableAdapter()
        let viewController = MainViewController(tableAdapter: tableAdapter, presenter: presenter)
        presenter.view = viewController
        
        return viewController
    }
}
