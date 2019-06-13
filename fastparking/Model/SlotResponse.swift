//
//  SlotResponse.swift
//  fastparking
//
//  Created by Jose Veliz on 6/12/19.
//  Copyright © 2019 Jose Veliz. All rights reserved.
//

import Foundation

struct SlotResponse: Codable {
    var status:String?
    var code:Int?
    var slots:Slot?
    var totalResult:Int?
}


//{
//    "status": "ok",
//    "slots": [
//    
//    ],
//    "totalResults": 1,
//    "code": 200
//}
