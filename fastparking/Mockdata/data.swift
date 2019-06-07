//
//  data.swift
//  fastparking
//
//  Created by Jose Veliz on 5/21/19.
//  Copyright © 2019 Jose Veliz. All rights reserved.
//

import Foundation

var ownerResponse = """
{
    "status": "ok",
    "owners": [
        {
            "id": 2,
            "fullName": "Playa de Estacionamiento Mano Poderosa de Cristo",
            "address": "Calle Faustino Sánchez Carrión 173 (Ex. Jr. Justo A. Vigil)",
            "slotsQuantity": 15,
            "isAvailable": true,
            "ruc": "20100098041",
            "birthday": null,
            "description": null,
            "email": null,
            "password": null,
            "latitude": -11.9943094,
            "longitude": -77.05193,
            "distance": "19.9 km",
            "duration": "37 mins",
            "rating": 4,
            "urlImage": null
        },
        {
            "id": 1,
            "fullName": "Playa de Estacionamiento 24 horas - Purban",
            "address": "Jirón Lampa 787, Jiron Puno 309, Cercado de Lima 15001",
            "slotsQuantity": 10,
            "isAvailable": true,
            "ruc": "20549500553",
            "birthday": null,
            "description": null,
            "email": null,
            "password": null,
            "latitude": -12.050807,
            "longitude": -77.03175,
            "distance": "27.7 km",
            "duration": "50 mins",
            "rating": 3.5,
            "urlImage": null
        }
    ],
    "totalResults": 2,
    "code": 200
}
""".data(using: .utf8)

