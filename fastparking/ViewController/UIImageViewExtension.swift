//
//  UIImageViewExtension.swift
//  fastparking
//
//  Created by Jose Veliz on 5/22/19.
//  Copyright © 2019 Jose Veliz. All rights reserved.
//
import Foundation
import UIKit
import os

extension UIImageView{
    func setImageFrom(urlString: String, withDefaultNamed defaultName: String?,
                      withErrorNamed errorImage: String?){
        guard let url = URL(string: urlString)else{
            _="Error while creating URL, default image assigned"
            //print(message)
            DispatchQueue.main.async {
                if let name=defaultName{
                    self.image=UIImage(named: name)
                }
            }
            return
        }
        URLSession.shared.dataTask(with: url){ (data,response,error) in
            guard let urlResponse=response as? HTTPURLResponse,
                urlResponse.statusCode==200,
                let mimeType=response?.mimeType,
                mimeType.hasPrefix("image"),
                let data=data,
                error==nil,
                let image=UIImage(data: data)else{
                    _="Error while requesting image, error image assigned"
                    //print(message )
                    DispatchQueue.main.async {
                        if let name=errorImage{
                            self.image=UIImage(named: name)
                        }
                    }
                    return
            }
            DispatchQueue.main.async {
                self.image=image
                _="Succesful request, image assigned"
                //print(message)
            }
            }.resume()
    }
}
