//
//  dogAPIClient.swift
//  January 14 2020 Collection View dogs
//
//  Created by Margiett Gil on 1/14/20.
//  Copyright © 2020 Margiett Gil. All rights reserved.
//

import Foundation
import NetworkHelper

struct DogAPIClient {
    static func fetchDogs(completion: @escaping (Result<[String], AppError>) -> ()) {
        let endpointURLString = "https://dog.ceo/api/breeds/image/random/50"
        guard let url = URL(string: endpointURLString) else {
            completion(.failure(.badURL(endpointURLString)))
            return
        }
        let request = URLRequest(url : url)
        // this is a singleton
        NetworkHelper.shared.performDataTask(with: request) { (result) in
            switch result {
            case . failure(let appError):
            completion(.failure(.networkClientError(appError)))
            case .success(let data):
                do {
                    let result = try JSONDecoder().decode(RandomDogInfo.self, from: data)
                    completion(.success(result.message))
                } catch {
                    completion(.failure(.decodingError(error)))
                }
            }
        }
    }
}
