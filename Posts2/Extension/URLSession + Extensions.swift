//
//  URLSession + Extensions.swift
//  Posts2
//
//  Created by Dmytro Ukrainskyi on 12.09.2023.
//

import Foundation

extension URLSession {
    
    func fetchDataWith<T: Decodable>(url: URL?, jsonDecoder: JSONDecoder) async throws -> T {
        guard let url else {
            throw generateError(description: "Bad URL")
        }
        
        let (data, response) = try await self.data(from: url)
        
        guard let response = response as? HTTPURLResponse else {
            throw generateError(description: "Bad Response")
        }
        
        switch response.statusCode {
        case (200...299):
            do {
                let decodedData = try jsonDecoder.decode(T.self, from: data)
                return decodedData
            } catch {
                throw generateError(description: error.localizedDescription)
            }
        default:
            throw generateError(
                code: response.statusCode,
                description: "A server error occured"
            )
        }
    }
    
    private func generateError(code: Int = 1, description: String) -> Error {
        NSError(
            domain: "Posts",
            code: code,
            userInfo: [NSLocalizedDescriptionKey: description]
        )
    }
    
}
