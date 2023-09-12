//
//  CommentService.swift
//  DevHive Posts Draft
//
//  Created by Dmytro Ukrainskyi on 12.09.2023.
//

import Foundation

protocol CommentService {
    
    func fetchCommentsForPostWith(id postID: Int) async throws -> [Comment]
    
}

final class RealCommentService: CommentService {
    
    // MARK: Private Properties
    
    private let postsAPI = "https://jsonplaceholder.typicode.com/comments"
    private let urlSession: URLSession = URLSession.shared
    private let jsonDecoder: JSONDecoder = JSONDecoder()
    
    // MARK: Public Methods
    
    func fetchCommentsForPostWith(id postID: Int) async throws -> [Comment] {
        let url = generateURLForCommentsOfPostWith(id: postID)
        
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
    
    private func generateURLForCommentsOfPostWith(id postID: Int) -> URL? {
        let url: URL? = URL(string: postsAPI)
        let postQuery = URLQueryItem(name: "postId", value: "\(postID)")
        
        return url?.appending(queryItems: [postQuery])
    }
    
}
