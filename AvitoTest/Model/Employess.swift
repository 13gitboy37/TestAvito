//
//  Employess.swift
//  AvitoTest
//
//  Created by Никита Мошенцев on 07.11.2022.
//

import Foundation

struct Employees {
    let name: String
    let phoneNumber: String
    let skills: [String]
}

extension Employees: Codable {
    enum CodingKeys: String, CodingKey {
        case name
        case phoneNumber = "phone_number"
        case skills
    }
}
