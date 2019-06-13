//
//  Slot.swift
//  fastparking
//
//  Created by Jose Veliz on 6/12/19.
//  Copyright © 2019 Jose Veliz. All rights reserved.
//

import Foundation

struct Slot: Codable {
    var id:Int
    var identifier:String?
    var ownerId:Int?
    var description:String?
    var isAvailable:Bool?
    var activeField:Bool?
}


//    "id": 1,
//    "identifier": "Slot1a",
//    "ownerId": 2,
//    "description": "Espacio de estacionamiento con medidas de 2,20 metros de anchura por 4,50 metros de longitud.",
//    "isAvailable": true,
//    "activeField": true
//    }
