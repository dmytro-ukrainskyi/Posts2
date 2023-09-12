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

final class MockPostService: PostService {
    
    func fetchPostsForUserWith(id userID: Int) async throws -> [Post] {
        let mockPost = Post(id: 1, userID: 1, title: "Test Title", body: "Test Body")
        return Array(repeating: mockPost, count: 10)
    }
    
}
