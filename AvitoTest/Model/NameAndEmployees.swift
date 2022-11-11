//
//  NameAndEmployees.swift
//  AvitoTest
//
//  Created by Никита Мошенцев on 08.11.2022.
//

import Foundation

struct NameAndEmpoloyess {
    let name: String
    let employees: [Employees]
}

extension NameAndEmpoloyess: Codable {
    enum CodingKeys: String, CodingKey {
        case name
        case employees
    }
}
