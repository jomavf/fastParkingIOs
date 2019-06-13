//
//  LoginResponse.swift
//  fastparking
//
//  Created by Jose Veliz on 6/7/19.
//  Copyright © 2019 Jose Veliz. All rights reserved.
//

import Foundation

//{
//    "status": "ok",
//    "code": 200,
//    "token": "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1bmlxdWVfbmFtZSI6IjEyM0BnbWFpbC5jb20iLCJuYmYiOjE1NTk5NjMwMzEsImV4cCI6MTU1OTk2NDgzMSwiaWF0IjoxNTU5OTYzMDMxLCJpc3MiOiJodHRwOi8vbG9jYWxob3N0OjU0OTcyIiwiYXVkIjoiaHR0cDovL2xvY2FsaG9zdDo1NDk3MiJ9.q0k1yB5XN1TUKpWCFJpKeGexETxj7FR7y8G7o4Ut_10"
//}

struct LoginResponse: Codable {
    var status: String?
    var code: Int?
    var token:String?
    var message:String?
    var customer:Customer?
}
