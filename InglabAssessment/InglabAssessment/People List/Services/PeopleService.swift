//
//  PeopleServices.swift
//  InglabAssessment
//
//  Created by Mohamed Fawzy on 09/10/2022.
//

import Foundation

enum ServiceError: Error {
    case network
    case parsing
    case unknown
    
    var description: String {
        switch self {
        case .network:
            return "Connection error"
        case .parsing:
            return "Unexpected response"
        case .unknown:
            return "Unknown error"
        }
    }
}

protocol PeopleServiceProtocol {
    func fetchAllPeople(completion: @escaping (Result<[Person], ServiceError>) -> Void)
}

class PeopleService: PeopleServiceProtocol {
    let session = URLSession.shared
    
    func fetchAllPeople(completion: @escaping (Result<[Person], ServiceError>) -> Void) {
        let task = session.dataTask(with: API.PeopleAPI.url) { data, _, error in
            if let _ = error {
                completion(.failure(.network))
            } else if let data = data {
                let decoder = JSONDecoder()
                do {
                    let result = try decoder.decode([Person].self, from: data)
                    completion(.success(result))
                } catch {
                    completion(.failure(.parsing))
                }
            } else {
                completion(.failure(.unknown))
            }
        }
        task.resume()
    }
}
