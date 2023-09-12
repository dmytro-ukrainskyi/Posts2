//
//  User.swift
//  DevHive Posts Draft
//
//  Created by Dmytro Ukrainskyi on 12.09.2023.
//

import Foundation

struct User: Decodable {
    
    let id: Int
    let name: String
    let username: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case username
    }
    
}
