//
//  Reservations.swift
//  fastparking
//
//  Created by Jose Veliz on 6/12/19.
//  Copyright © 2019 Jose Veliz. All rights reserved.
//

import Foundation

struct Reservation: Codable {
    var id:Int
    var customerId:Int?
    var ownerId:Int?
    var startReservationDate:String?
    var endReservationDate:String?
    var isActive: Bool?
    var rating:Int?
    var activeField: Bool?
    var customer:Customer?
    var owner:Owner?
}
