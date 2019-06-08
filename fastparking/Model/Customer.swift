//
//  Customer.swift
//  fastparking
//
//  Created by Jose Veliz on 6/7/19.
//  Copyright © 2019 Jose Veliz. All rights reserved.
//

import Foundation

//{
//    "id": 1,
//    "firstName": "Kevin",
//    "lastName": "Aranibar Villegas",
//    "address": null,
//    "birthday": "1996-03-23T00:00:00",
//    "dni": "79203299",
//    "ruc": "20514067881",
//    "fullName": null,
//    "activeField": true,
//    "email": "kevinaranibarvillegas@gmail.com",
//    "password": "u201512321"
//},

struct Customer {
    var id:Int
    var firstName:String?
    var lastName:String?
    var address:String?
    var birthday:String?
    var dni:String?
    var ruc:String?
    var fullname:String?
    var activatedField:Bool?
    var email:String?
    var password:String?
}
