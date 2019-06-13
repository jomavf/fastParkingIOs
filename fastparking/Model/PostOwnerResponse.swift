//
//  OwnerResponse.swift
//  fastparking
//
//  Created by Jose Veliz on 5/21/19.
//  Copyright © 2019 Jose Veliz. All rights reserved.
//

import Foundation

struct PostOwnerResponse: Codable {
    var status: String?
    var owner: Owner?
    var code: Int?
}
