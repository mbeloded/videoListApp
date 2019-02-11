//
//  ParserHelper.swift
//  videoDownloadingApp
//
//  Created by Michael Bielodied on 2/6/19.
//  Copyright © 2019 Michael Bielodied. All rights reserved.
//

import Foundation

protocol Parceable {
    static func parseObject(dictionary: [String: AnyObject]) -> Result<Self, ErrorResult>
}

final class ParserHelper {
    
    //in case if we need to work with dictionaries
    static func parse<T: Parceable>(dataAsDict: Data, completion : (Result<T, ErrorResult>) -> Void) {
        do {
            if let dictionary = try JSONSerialization.jsonObject(with: dataAsDict, options: .allowFragments) as? [String: AnyObject] {

                // init final result
                // check foreach dictionary if parseable
                switch T.parseObject(dictionary: dictionary) {
                case .failure(let error):
                    completion(.failure(error))
                    break
                case .success(let newModel):
                    completion(.success(newModel))
                    break
                }


            } else {
                // not an array
                completion(.failure(.parser(string: "Json data is not an array")))
            }
        } catch {
            // can't parse json
            completion(.failure(.parser(string: "Error while parsing json data")))
        }
    }
    
    //easier way to work with json data as Decodable obj.
    static func parse<T: Decodable>(data: Data, completion : (Result<T, ErrorResult>) -> Void) {
        
        if let responseObject = try? JSONDecoder().decode(T.self, from: data) {
            completion(.success(responseObject))
        } else {
            completion(.failure(.parser(string: "Unable to parse the json")))
        }
    }
}
