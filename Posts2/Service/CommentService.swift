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

final class MockCommentService: CommentService {
    
    func fetchCommentsForPostWith(id postID: Int) async throws -> [Comment] {
        let mockComment = Comment(
            id: 1,
            postID: postID,
            name: "Test Name",
            email: "test@testmail.com",
            body: "Test Body"
        )
        return Array(repeating: mockComment, count: 10)
    }
    
}
