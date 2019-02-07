//
//  APIService.swift
//  videoDownloadingApp
//
//  Created by Michael Bielodied on 2/3/19.
//  Copyright © 2019 Michael Bielodied. All rights reserved.
//

import Foundation

typealias NetworkCompletionHandler = (Data?, URLResponse?, Error?) -> Void
typealias ErrorHandler = (String) -> Void

class APIService {
    
    static let genericError = "Something went wrong. Please try again later"
    
    static let emptyResponse = "Unable to parse data. Empty response"
    static let wrongUrl = "Unable to create URL from given string"
    
    func get(urlString: String = "",
                           headers: [String: String] = [:], completion: @escaping (Result<Data, ErrorResult>) -> Void) {
        
        let completionHandler: NetworkCompletionHandler = { (data, urlResponse, error) in
            
            if let error = error {
                print(error.localizedDescription)
                completion(.failure(.network(string: error.localizedDescription)))
                return
            }
            
            if self.isSuccessCode(urlResponse) {
                guard let data = data else {
                    
                    completion(.failure(.network(string: APIService.emptyResponse)))
                    return
                }
                
                completion(.success(data))
                
            }
            else {
                completion(.failure(.network(string: APIService.genericError)))
            }
        }
        
        guard let url = URL(string: urlString) else {
            completion(.failure(.network(string: APIService.wrongUrl)))
            return
        }
        
        var request = URLRequest(url: url)
        request.allHTTPHeaderFields = headers
        URLSession.shared.dataTask(with: request,
                                   completionHandler: completionHandler)
            .resume()
    }
    
    private func isSuccessCode(_ statusCode: Int) -> Bool {
        return statusCode >= 200 && statusCode < 300
    }
    
    private func isSuccessCode(_ response: URLResponse?) -> Bool {
        guard let urlResponse = response as? HTTPURLResponse else {
            return false
        }
        return isSuccessCode(urlResponse.statusCode)
    }
    
}
