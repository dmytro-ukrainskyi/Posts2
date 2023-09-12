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

final class RealUserService: UserService {
    
    private let usersAPI = "https://jsonplaceholder.typicode.com/users"
    private let urlSession: URLSession = URLSession.shared
    private let jsonDecoder: JSONDecoder = JSONDecoder()
    
    // MARK: Public Methods
    
    func fetchUsers() async throws -> [User] {
        let url = URL(string: usersAPI)
        
        do {
            return try await urlSession.fetchDataWith(
                url: url,
                jsonDecoder: jsonDecoder
            )
        } catch {
            throw error
        }
    }
    
    func fetchUserWith(id: Int) async throws -> User {
        let url = generateURLForUserWith(id: id)
        
        do {
            let usersResponce: [User] = try await urlSession.fetchDataWith(
                url: url,
                jsonDecoder: jsonDecoder
            )
            
            guard let user = usersResponce.first else {
                throw NSError(
                    domain: "Posts",
                    code: 1,
                    userInfo: [NSLocalizedDescriptionKey: "No user with id \(id)"])
            }
            
            return user
        } catch {
            throw error
        }
    }
    
    // MARK: Private Methods
    
    private func generateURLForUserWith(id: Int) -> URL? {
        let url: URL? = URL(string: usersAPI)
        let idQuery = URLQueryItem(name: "id", value: "\(id)")
        
        return url?.appending(queryItems: [idQuery])
    }
    
}
