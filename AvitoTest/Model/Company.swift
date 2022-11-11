//
//  Company.swift
//  AvitoTest
//
//  Created by Никита Мошенцев on 08.11.2022.
//

import Foundation

struct Company {
    let company: NameAndEmpoloyess
}

extension Company: Codable {
    enum CodingKeys: String, CodingKey {
        case company
    }
}
