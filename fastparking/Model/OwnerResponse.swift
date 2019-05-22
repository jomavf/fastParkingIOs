//
//  OwnerResponse.swift
//  fastparking
//
//  Created by Jose Veliz on 5/21/19.
//  Copyright © 2019 Jose Veliz. All rights reserved.
//

import Foundation

class OwnerResponse: Codable {
    var status: String?
    var owners: [Owner]?
    var totalResults:Int?
    var code: Int?
}
