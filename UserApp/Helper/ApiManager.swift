//
//  ApiManager.swift
//  UserApp
//
//  Created by Vishnu - iOS on 10/10/23.
//

import Foundation
import Alamofire

enum DataError: Error {
    case invalidURL
    case invalidData
    case invalidResponse
    case message(_ error: Error)
}

class ApiManger {
    
    private init(){}
    
    static let shared = ApiManger()
    
    func fetchData<T>(page: Int, completion: @escaping (Result<T, DataError>) -> Void) where T: Codable {
        guard let url = URL(string: Constant.Api.baseURL + String(page)) else {
            completion(.failure(.invalidURL))
            return
        }
        AF.request(url, method: .get).responseData(completionHandler: {response in
            switch response.result{
            case .success(let res):
                if let code = response.response?.statusCode{
                    switch code {
                    case 200...299:
                        do {
                            completion(.success(try JSONDecoder().decode(T.self, from: res)))
                        } catch let error {
                            completion(.failure(.message(error)))
                        }
                    default:
                        completion(.failure(.invalidResponse))
                    }
                }
            case .failure:
                completion(.failure(.invalidData))
            }
        })
    }
}
