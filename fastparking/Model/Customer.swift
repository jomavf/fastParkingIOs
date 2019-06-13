//
//  Customer.swift
//  fastparking
//
//  Created by Jose Veliz on 6/12/19.
//  Copyright © 2019 Jose Veliz. All rights reserved.
//

import Foundation

struct Customer:Codable {
    var id: Int
    var firstName: String?
    var lastName: String?
    var address: String?
    var birthday: String?
    var dni: String?
    var ruc: String?
    var fullName: String?
    var email: String?
    var password: String?
    var activeField: Bool?
}
