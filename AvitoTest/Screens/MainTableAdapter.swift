//
//  MainTableAdapter.swift
//  AvitoTest
//
//  Created by Никита Мошенцев on 07.11.2022.
//

import UIKit

final class MainTableAdapter: NSObject {
    
    // MARK: - Properties
    
    var employees: [Employees] = [] 
}

// MARK: - UITableViewDataSource

extension MainTableAdapter: UITableViewDataSource {
    func tableView(_: UITableView, numberOfRowsInSection _: Int) -> Int {
        employees.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let currentEmployee = employees[indexPath.row]
        guard
            let cell = tableView.dequeueReusableCell(withIdentifier: MainCell.reuceID, for: indexPath) as? MainCell
        else { return UITableViewCell() }
        cell.configure(employees: currentEmployee)
        return cell
    }
}

// MARK: - UITableViewDelegate

extension MainTableAdapter: UITableViewDelegate {
}
