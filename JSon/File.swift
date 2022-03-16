//
//  File.swift
//  JSon
//
//  Created by anvar on 24/02/22.
//

import Foundation
import Alamofire
enum NetworkError: Error {
    case invalidURL
    case noData
    case decodingError
}

class NetworkManager {
    
    
    static var shared = NetworkManager()
  
    func fetch<T: Decodable>(dataType: T.Type, from url: String, convertFromSnakeCase: Bool = true, completion: @escaping(Result<T, NetworkError>) -> Void) {
        guard let url = URL(string: url) else {
            completion(.failure(.invalidURL))
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data else {
                completion(.failure(.noData))
                print(error?.localizedDescription ?? "No error description")
                return
            }
            do {
                let decoder = JSONDecoder()
                if convertFromSnakeCase {
                    decoder.keyDecodingStrategy = .convertFromSnakeCase
                }
                
                let type = try decoder.decode(T.self, from: data)
                DispatchQueue.main.async {
                    completion(.success(type))
                }
            } catch {
                completion(.failure(.decodingError))
            }
        }.resume()
    }
//    func fetchDataWithAlomafire(_ url: String, completion: @escaping(Result<[Market], NetworkError>) -> Void) {
//        AF.request(url)
//            .validate()
//            .responseJSON { dataResponse in
//                switch dataResponse.result {
//                case .success(let value):
//                    let courses = Course.getCourses(from: value)
//                    completion(.success(courses))
//                case .failure:
//                    completion(.failure(.decodingError))
//                }
//            }
//    }
//
    
    private init() {}
}
