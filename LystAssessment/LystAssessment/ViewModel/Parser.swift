//
//  Parser.swift
//  LystAssessment
//
//  Created by Vishwanath Kota on 30/09/21.
//

import Foundation

class Parser {
    //    MARK:- Objects & Variables
    var catsBreed = [Breed]()
    weak var vc : ViewController!
    
    //    MARK:- Get API Calls
    /// Get cat breeds API Call
    ///  Here I am using the Network handler helper class which takes care of all the url sessions 
    func getRowsInfoFromAPI() {
        Network.getApiCallWithRequestString(requestString: URLConstants.catBreedsURL) { (response) in
            switch response {
            case .failure(let error):
                
                if let urlError = error as? URLError{
                    switch urlError {
                    case .dataNotFound:     print("Data not found")
                    case .unformatedURL:    print("Unformated url")
                    }
                } else {
                    print("Error:- \(error)")
                }
                
            case .success(let responseData):
                do {
                    let str = String(decoding: responseData, as: UTF8.self)
                    if let data = str.data(using: .utf8) {
                        let jsonDecoder = JSONDecoder()
                        let responseModel = try jsonDecoder.decode([Breed].self, from: data)
                        self.catsBreed = responseModel
                        DispatchQueue.main.async {
                            self.vc.catsCollectionView.reloadData()
                        }
                    }
                }
                
                catch(let error) {
                    print(error.localizedDescription)
                }
            }
        }
    }
}
