//
//  MainView.swift
//  AvitoTest
//
//  Created by Никита Мошенцев on 07.11.2022.
//

import UIKit

final class MainView: UIView {
    
    //MARK: Properties
    
    weak var mainViewController: MainViewController?
    
    private(set) lazy var connectionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 14)
        label.layer.backgroundColor = UIColor.systemGray6.withAlphaComponent(0.9).cgColor
        label.text = "Отсутсвует подключение к интернету"
        label.isHidden = true
        return label
    }()
    
    private(set) lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.rowHeight = 60
        tableView.register(MainCell.self, forCellReuseIdentifier: MainCell.reuceID)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    //MARK: Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: Methods
    
    private func configureUI() {
        addSubview(tableView)
        tableView.addSubview(connectionLabel)
    }
    
   
    
    func configureConnectionView() {
        connectionLabel.text = "Подключение восстановлено"
        connectionLabel.textColor = .green
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            self.connectionLabel.isHidden = true
        }
    }
    
    func configureNotConnectionView() {
        connectionLabel.text = "Отсутсвует подключение к интернету"
        connectionLabel.textColor = .red
        connectionLabel.isHidden = false
    }
}

extension MainView {
    private struct Layout {
        static let heighConnectionLabel = 30.0
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: self.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            
            connectionLabel.topAnchor.constraint(equalTo: tableView.topAnchor),
            connectionLabel.centerXAnchor.constraint(equalTo: tableView.centerXAnchor),
            connectionLabel.heightAnchor.constraint(equalToConstant: Layout.heighConnectionLabel),
        ])
    }
}
