//
//  NetworkMonitor.swift
//  AvitoTest
//
//  Created by Никита Мошенцев on 09.11.2022.
//

import Foundation
import Network

extension Notification.Name {
    static let connectivityStatus = Notification.Name(rawValue: "connectivityStatusChanged")
}

final class NetworkMonitor {
    
    //MARK: Properties
    
    static let shared = NetworkMonitor()
    
    private let queue = DispatchQueue.global()
    private let monitor: NWPathMonitor
    
    public private(set) var isConnected = false
    
    //MARK: - Init
    
    private init() {
        self.monitor = NWPathMonitor()
    }
    
    //MARK: - Methods
    
    public func startMonitoring() {
        monitor.pathUpdateHandler = { [weak self] path in
            self?.isConnected = path.status != .unsatisfied
            NotificationCenter.default.post(name: .connectivityStatus, object: nil)
        }
        monitor.start(queue: queue)
    }
    
    public func stopMonitoring() {
        monitor.cancel()
    }
}
