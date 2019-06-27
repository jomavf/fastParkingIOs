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
    static let fakeUrl = "http://127.0.0.1:3000"
    static let baseUrl = "http://fastparking.gearhostpreview.com/FastParking/v1"
    static let ownerUrl = "\(baseUrl)/owners?latitude=-11.87&longitude=-77.086"
    static let loginUrl = "\(baseUrl)/login/authenticate"
    static let ownerUrlPost = "\(baseUrl)/owners"
    static let customerUrl = "\(baseUrl)/customers"
    static var reservationUrl:String?
    
    static func createReservationUrl(_ id:Int) -> String{
        return "\(fastParkingAPI.baseUrl)/customers/\(id)/reservations"
    }
    
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
        AF.request(url,parameters:parameters).responseJSON { (response) in
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
        parameters: [String:Any],
        responseHandler: @escaping (T) -> Void,
        errorHandler: @escaping (Error) -> Void
        ){
        guard let url = URL(string: urlString) else {
            let message = "ZGH-> Error in URL"
            print(message)
            return
        }
        AF.request(url,method: .post,parameters:parameters).responseJSON { (response) in
            print("response :",response)
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
    
    static func postOwners(parameter:[String:Any], responseHandler: @escaping (PostOwnerResponse)->Void,errorHandler: @escaping (Error)->Void){
        self.post(urlString: ownerUrlPost, parameters: parameter, responseHandler: responseHandler, errorHandler: errorHandler)
    }
    static func postCustomer(parameter:[String:Any], responseHandler: @escaping (CustomerResponse)->Void,errorHandler: @escaping (Error)->Void){
        self.post(urlString: customerUrl, parameters: parameter, responseHandler: responseHandler, errorHandler: errorHandler)
    }
    
    static func getReservation(reservationId id:Int?,responseHandler: @escaping (ReservationResponse)->Void,errorHandler: @escaping (Error)->Void){
        let parameter = ["":""]
        if let id = id {
            let url = fastParkingAPI.createReservationUrl(id)
            self.get(urlString: url, parameters:parameter, responseHandler: responseHandler, errorHandler: errorHandler)
        } else {
            print("Reservation url not working")
        }
    }
    
    static func postReservation(reservationId id:Int?,parameter:[String:Any], responseHandler: @escaping (ReservationResponse)->Void,errorHandler: @escaping (Error)->Void){
        if let id = id {
            let url = fastParkingAPI.createReservationUrl(id)
            self.post(urlString: String(url), parameters: parameter, responseHandler: responseHandler, errorHandler: errorHandler)
        } else {
            print("Reservation url not working")
        }
    }
}

