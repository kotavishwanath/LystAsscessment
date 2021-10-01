//
//  NetworkHandler.swift
//  LystAssessment
//
//  Created by Vishwanath Kota on 30/09/21.
//

import Foundation

class Network {
    /// Get API Call
    static func getApiCallWithRequestString(requestString: String, completionBlock: @escaping((Result<Data, Error>) -> Void)) {
        
        guard let url = URL(string: requestString) else {
            completionBlock(.failure(URLError.unformatedURL))
            return
        }
        
        let dataTask = URLSession.shared.dataTask(with: url) { (responseData, httpResponse, error) in
            
            if let err = error {
                completionBlock(.failure(err))
                return
            }
            
            guard let response = responseData else {
                completionBlock(.failure(URLError.dataNotFound))
                return
            }
            
            completionBlock(.success(response))
        }
        dataTask.resume();
    }
}
