//
//  CustomerResponse.swift
//  fastparking
//
//  Created by Jose Veliz on 6/12/19.
//  Copyright © 2019 Jose Veliz. All rights reserved.
//

import Foundation

struct CustomerResponse: Codable {
    var status:String?
    var code:Int?
    var customer:Customer?
}
