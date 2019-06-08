//
//  fastParkingAPI.swift
//  fastparking
//
//  Created by Jose Veliz on 6/7/19.
//  Copyright © 2019 Jose Veliz. All rights reserved.
//

import Foundation
import Alamofire

class fastParkingAPI {
    static let baseUrl = "http://fastparking.gearhostpreview.com/FastParking/v1"
    static let ownerUrl = "\(baseUrl)/owners"
    static let loginUrl = "\(baseUrl)/login/authenticate"
    
    static private func get<T:Decodable>(
        urlString:String,
        parameters: [String:String],
        responseHandler: @escaping (T) -> Void,
        errorHandler: @escaping (Error) -> Void
    ){
        guard let url = URL(string: urlString) else {
            let message = "ZGH-> Error in URL"
            print(message)
            return
        }
        AF.request(url,parameters:parameters).validate().responseJSON { (response) in
            switch response.result {
            case .success(_):
                do {
                    let jsonDecoder = JSONDecoder()
                    if let data = response.data {
                        let dataResponse = try jsonDecoder.decode(T.self, from: data)
                        responseHandler(dataResponse)
                    }
                } catch let error {
                    print("ZGH-> Error while getting response: ",error)
                }
            case .failure(let error):
                errorHandler(error)
            }
        }
    }
    
    static private func post<T:Decodable>(
        urlString:String,
        parameters: [String:String],
        responseHandler: @escaping (T) -> Void,
        errorHandler: @escaping (Error) -> Void
        ){
        guard let url = URL(string: urlString) else {
            let message = "ZGH-> Error in URL"
            print(message)
            return
        }
        AF.request(url,method: .post,parameters:parameters).responseJSON { (response) in
            switch response.result {
            case .success(_):
                do {
                    let jsonDecoder = JSONDecoder()
                    if let data = response.data {
                        let dataResponse = try jsonDecoder.decode(T.self, from: data)
                        responseHandler(dataResponse)
                    }
                } catch let error {
                    print("ZGH-> Error while getting response: ",error)
                }
            case .failure(let error):
                errorHandler(error)
            }
        }
    }
    
    static func getOwners(responseHandler: @escaping (OwnerResponse)->Void,errorHandler: @escaping (Error)->Void){
        let parameter = ["":""]
        self.get(urlString: ownerUrl, parameters:parameter, responseHandler: responseHandler, errorHandler: errorHandler)
    }
    
    static func loginRequest(parameter:[String:String], responseHandler: @escaping (LoginResponse)->Void,errorHandler: @escaping (Error)->Void){
        self.post(urlString: loginUrl, parameters: parameter, responseHandler: responseHandler, errorHandler: errorHandler)
    }
}

