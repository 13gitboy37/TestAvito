//
//  DataService.swift
//  AvitoTest
//
//  Created by Никита Мошенцев on 08.11.2022.
//

import Foundation
import UIKit

protocol StorageServiceProtocol {
    func getEmployees(completion: @escaping ([Employees]) -> Void)
}

final class StorageService {
    
    //MARK: - Properties
    
    private var employeesData: [Employees]? 
    private let cacheLifeTime: TimeInterval = 60 * 60
    
    private let networkService: NetworkServiceProtocol?

    private static let pathName: String = {
        let pathName = "Employees"
        
        guard let cachesDirectroy = FileManager.default.urls(
                                                for: .cachesDirectory,
                                                in: .userDomainMask).first else { return pathName}
        let url = cachesDirectroy.appendingPathComponent(pathName, isDirectory: true)
        if !FileManager.default.fileExists(atPath: url.path) {
            try? FileManager.default.createDirectory(at: url, withIntermediateDirectories: true, attributes: nil)
        }
        return pathName
    }()
    
    init(networkService: NetworkServiceProtocol?) {
        self.networkService = networkService
    }
    
    //MARK: - Methods
    
    private func getDataFromCache() -> [Employees]? {
        guard let fileName = getFilePath(),
              let info = try? FileManager.default.attributesOfItem(atPath: fileName),
              let modificationDate = info[FileAttributeKey.modificationDate] as? Date
        else { return nil }
    
        let lifeTime = Date().timeIntervalSince(modificationDate)
        
        guard lifeTime <= cacheLifeTime,
              let data = FileManager.default.contents(atPath: fileName)
        else { return nil }
        let employees = try? JSONDecoder().decode([Employees].self, from: data)
        return employees
    }
    
    private func getFilePath() -> String? {
        guard let cachesDirectory = FileManager.default.urls(for: .cachesDirectory,
                                                             in: .userDomainMask).first
        else { return nil }
        
        let hashName = "Employees"
        return cachesDirectory.appendingPathComponent(StorageService.pathName + "/" + hashName).path
    }
    
    private func loadData(completion: @escaping ([Employees]) -> Void) {
        networkService?.getEmployees { [weak self] result in
            switch result {
            case.success(let company):
                let employees = company.company.employees.sorted { $0.name < $1.name }
                self?.employeesData = employees
                completion(employees)
                self?.saveDataToCache(employees: employees)
            case .failure(let error):
                print(error)
            }
        }
    }
    
    private func saveDataToCache(employees: [Employees]) {
        guard let fileName = getFilePath(),
              let data = try? JSONEncoder().encode(employeesData)
        else { return }
        print(fileName)
        FileManager.default.createFile(atPath: fileName, contents: data, attributes: nil)
    }
}

//MARK: Release StorageServiceProtocol

extension StorageService: StorageServiceProtocol {
    func getEmployees(completion: @escaping ([Employees]) -> Void) {
        
        if let employees = employeesData {
            completion(employees)
        } else if let employees = getDataFromCache() {
            completion(employees)
        } else {
            loadData { employeesLoad in
                completion(employeesLoad)
            }
        }
    }
}
