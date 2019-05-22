//
//  Owner.swift
//  fastparking
//
//  Created by Jose Veliz on 5/21/19.
//  Copyright © 2019 Jose Veliz. All rights reserved.
//

import Foundation

class Owner:Codable {
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
    var imageUrl:String?
    init(id:Int,fullName:String?,address:String?,slotsQuantity:Int?,isAvailable:Bool?,ruc:String?,birthday:String?,description:String?,email:String?,password:String?,imageUrl:String?){
        self.id = id
        self.fullName = fullName
        self.address = address
        self.slotsQuantity = slotsQuantity
        self.isAvailable = isAvailable
        self.ruc = ruc
        self.birthday = birthday
        self.description = description
        self.email = email
        self.password = password
        self.imageUrl = imageUrl
    }
    
}
