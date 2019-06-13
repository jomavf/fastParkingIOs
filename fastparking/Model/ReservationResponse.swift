//
//  ReservationResponse.swift
//  fastparking
//
//  Created by Jose Veliz on 6/12/19.
//  Copyright © 2019 Jose Veliz. All rights reserved.
//

import Foundation

struct ReservationResponse: Codable {
    var status:String?
    var reservations:String?
    var code:Int?
    var totalResults:Int?
}
