//
//  Comment.swift
//  DevHive Posts Draft
//
//  Created by Dmytro Ukrainskyi on 12.09.2023.
//

import Foundation

struct Comment: Decodable {
    
    let id: Int
    let postID: Int
    let name: String
    let email: String
    let body: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case postID = "postId"
        case name
        case email
        case body
    }
    
}
