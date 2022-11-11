//
//  NetworkService.swift
//  AvitoTest
//
//  Created by Никита Мошенцев on 08.11.2022.
//

import Foundation

protocol NetworkServiceProtocol {
    func getEmployees(completion: @escaping (Result<Company,Error>) -> Void)
}

final class NetworkService {
    
    //MARK: - Properties
    
    lazy var mySession = URLSession(configuration: configuration)
    
    let configuration: URLSessionConfiguration = {
        let config = URLSessionConfiguration.default
        config.timeoutIntervalForRequest = 10.0
        return config
    }()
    
    private var urlConstructor: URLComponents = {
        var constructor = URLComponents()
        constructor.scheme = "https"
        constructor.host = "run.mocky.io"
        constructor.path = "/v3/1d1cb4ec-73db-4762-8c4b-0b8aa3cecd4c"
        return constructor
    }()
}

//MARK: - Release NetworkServiceProtocol

extension NetworkService: NetworkServiceProtocol {
    func getEmployees(completion: @escaping (Result<Company,Error>) -> Void) {
        guard
            let url = urlConstructor.url
        else { return }
        let task = mySession.dataTask(with: url) { data, response, error in
            if let response = response as? HTTPURLResponse {
                print(response.statusCode)
            }
            guard
                error == nil,
                let data = data
            else { return }
            do {
                let employessResponse = try JSONDecoder().decode(Company.self, from: data)
                completion(.success(employessResponse))
            } catch {
                print(error)
            }
        }
        task.resume()
    }
}
