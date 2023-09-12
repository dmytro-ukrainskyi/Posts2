//
//  Post.swift
//  DevHive Posts Draft
//
//  Created by Dmytro Ukrainskyi on 12.09.2023.
//

import Foundation

struct Post: Decodable {
    
    let id: Int
    let userID: Int
    let title: String
    let body: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case userID = "userId"
        case title
        case body
    }
    
}
