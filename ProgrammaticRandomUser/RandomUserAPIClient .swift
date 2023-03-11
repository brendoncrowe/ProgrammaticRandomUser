//
//  RandomUserAPIClient .swift
//  ProgrammaticRandomUser
//
//  Created by Brendon Crowe on 3/7/23.
//

import Foundation
import NetworkHelper


struct RandomUserAPIClient {
    
    static func fetchUsers(completion: @escaping (Result<[RandomUser], AppError>) -> ()) {
        let endpoint = "https://randomuser.me/api/?results=20"
        
        guard let url = URL(string: endpoint) else {
            completion(.failure(.badURL(endpoint)))
            return
        }
        
        let request = URLRequest(url: url)
        
        NetworkHelper.shared.performDataTask(with: request) { result in
            switch result {
            case .failure(let appError):
                completion(.failure(.networkClientError(appError)))
                return
            case .success(let data):
                do {
                    let searchResults = try JSONDecoder().decode(ResultsWrapper.self, from: data)
                    let users = searchResults.results
                    completion(.success(users))
                } catch {
                    completion(.failure(.decodingError(error)))
                }
            }
        }
    }
}
