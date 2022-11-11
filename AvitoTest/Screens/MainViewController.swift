//
//  ViewController.swift
//  AvitoTest
//
//  Created by Никита Мошенцев on 07.11.2022.
//

import UIKit

//MARK: MainViewInput

protocol MainViewInput: AnyObject {
    func reloadTable(withEmployees: [Employees])
    func configureConnectionView()
    func configureNotConnectionView()
}

final class MainViewController: UIViewController {
    
    //MARK: Properties
    
    private var mainView: MainView {
        guard let view = self.view as? MainView else {
            let correctView = MainView(frame: self.view.frame)
            self.view = correctView
            return correctView
        }
        return view
    }
    
    var presenter: MainViewOutput?
    
    var tableAdapter: MainTableAdapter?
    
    //MARK: Init
    
    init(tableAdapter: MainTableAdapter, presenter: MainViewOutput) {
        super.init(nibName: nil, bundle: nil)
        self.tableAdapter = tableAdapter
        self.presenter = presenter
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: Lifecycle
    
    override func loadView() {
        super.loadView()
        self.view = MainView(frame: self.view.frame)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mainView.mainViewController = self
        mainView.tableView.delegate = tableAdapter
        mainView.tableView.dataSource = tableAdapter
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        subscribeNotification()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        unsubscribeNotification()
    }
    
    //MARK: Methods
    
    private func subscribeNotification() {
        NotificationCenter.default.addObserver(self,
                                               selector:
                                                #selector(showOfflineDeviceUI(notification:)),
                                               name: NSNotification.Name.connectivityStatus, object: nil)
        NetworkMonitor.shared.startMonitoring()
    }
    
    private func unsubscribeNotification() {
        NotificationCenter.default.removeObserver(
            self,
            name: NSNotification.Name.connectivityStatus,
            object: nil)
        NetworkMonitor.shared.stopMonitoring()
    }
    
    @objc func showOfflineDeviceUI(notification: Notification) {
        presenter?.checkNetworkConnection()
    }
}

//MARK: Release MainViewInput

extension MainViewController: MainViewInput {
    func configureConnectionView() {
        DispatchQueue.main.async {
            self.mainView.configureConnectionView()
        }
    }
    
    func configureNotConnectionView() {
        DispatchQueue.main.async {
            self.mainView.configureNotConnectionView()
        }
    }
    
    func reloadTable(withEmployees: [Employees]) {
        tableAdapter?.employees = withEmployees
        DispatchQueue.main.async {
            self.mainView.tableView.reloadData()
        }
    }
}

