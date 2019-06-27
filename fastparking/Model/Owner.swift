//
//  Owner.swift
//  fastparking
//
//  Created by Jose Veliz on 5/21/19.
//  Copyright © 2019 Jose Veliz. All rights reserved.
//

import Foundation

struct Owner:Codable {
    var id: Int
    var fullName:String?
    var address:String?
    var slotsQuantity:Int?
    var isAvailable:Bool?
    var ruc:String?
    var birthday:String?
    var description:String?
    var email:String?
    var password:String?
    var latitude:Double?
    var longitude:Double?
    var distance:String?
    var duration:String?
    var rating:Float?
    var imageUrl:String?
    var price:Double?
    
//    {
//        "id": 35,
//        "fullName": "Jose",
//        "address": "Av Parqueo",
//        "slotsQuantity": 76,
//        "isAvailable": null,
//        "ruc": "70192348",
//        "birthday": "2012-06-02T00:00:00",
//        "description": "Descripcion de mi parqueo",
//        "email": "jveliz2@gmail.com",
//        "password": "jveliz2",
//        "latitude": -12.0415716,
//        "longitude": -77.03382,
//        "distance": "23.3 km",
//        "duration": "39 mins",
//        "rating": 0,
//        "imageUrl": null
//    },
    
//    enum CodingKeys:String,CodingKey {
//        case name = "title"
//        case foundingYear = "founding_date"
//    }
//    init(id:Int,fullName:String?,address:String?,slotsQuantity:Int?,isAvailable:Bool?,ruc:String?,birthday:String?,description:String?,email:String?,password:String?,imageUrl:String?){
//        self.id = id
//        self.fullName = fullName
//        self.address = address
//        self.slotsQuantity = slotsQuantity
//        self.isAvailable = isAvailable
//        self.ruc = ruc
//        self.birthday = birthday
//        self.description = description
//        self.email = email
//        self.password = password
//        self.imageUrl = imageUrl
//    }
    
}
