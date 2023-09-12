//
//  UserService.swift
//  DevHive Posts Draft
//
//  Created by Dmytro Ukrainskyi on 12.09.2023.
//

import Foundation

protocol UserService {
    
    func fetchUsers() async throws -> [User]
    func fetchUserWith(id: Int) async throws -> User
    
}

final class MockUserService: UserService {
    
    func fetchUsers() async throws -> [User] {
        [
            User(id: 1, name: "Test Name", username: "Test Username"),
            User(id: 2, name: "Test Name 2", username: "Test Username 2")
        ]
    }
    
    func fetchUserWith(id: Int) async throws -> User {
        User(id: id, name: "Test Name", username: "Test Username")
    }
    
}
