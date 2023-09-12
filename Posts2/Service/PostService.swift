//
//  PostService.swift
//  DevHive Posts Draft
//
//  Created by Dmytro Ukrainskyi on 12.09.2023.
//

import Foundation

protocol PostService {
    
    func fetchPostsForUserWith(id userID: Int) async throws -> [Post]
    
}

final class RealPostService: PostService {
    
    // MARK: Private Properties
    
    private let postsAPI = "https://jsonplaceholder.typicode.com/posts"
    private let urlSession: URLSession = URLSession.shared
    private let jsonDecoder: JSONDecoder = JSONDecoder()
    
    // MARK: Public Methods
    func fetchPostsForUserWith(id userID: Int) async throws -> [Post] {
        let url = generateURLForPostsOfUserWith(id: userID)
        
        do {
            return try await urlSession.fetchDataWith(
                url: url,
                jsonDecoder: jsonDecoder
            )
        } catch {
            throw error
        }
    }
    
    // MARK: Private Methods
    
    private func generateURLForPostsOfUserWith(id userID: Int) -> URL? {
        let url: URL? = URL(string: postsAPI)
        let userQuery = URLQueryItem(name: "userId", value: "\(userID)")
        
        return url?.appending(queryItems: [userQuery])
    }
    
}
