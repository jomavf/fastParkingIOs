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
      "id": 1,
      "fullName": "Playa de Estacionamiento 24 horas - Purban",
      "address": "Jirón Lampa 787, Jiron Puno 309, Cercado de Lima 15001",
      "slotsQuantity": 10,
      "isAvailable": true,
      "ruc": "20549500553",
      "birthday": null,
      "description": "El mejor lugar para guardar tu auto, se ofrecen servicios varios como lavado y limpiado premium de lunas",
      "email": null,
      "password": null,
      "imageUrl":"https://wonderfulengineering.com/wp-content/uploads/2014/08/25-garage-design-ideas-7-610x394.jpg"
    },
    {
      "id": 2,
      "fullName": "Playa de Estacionamiento Mano Poderosa de Cristo",
      "address": "Calle Faustino Sánchez Carrión 173 (Ex. Jr. Justo A. Vigil)",
      "slotsQuantity": 15,
      "isAvailable": false,
      "ruc": "20100098041",
      "birthday": null,
      "description": "Lugar amplio con servicio de lavado y pintado de autos chicos.",
      "email": null,
      "password": null,
      "imageUrl":"https://wonderfulengineering.com/wp-content/uploads/2014/08/25-garage-design-ideas-7-610x394.jpg"
    },
    {
      "id": 3,
      "fullName": "Playa de Estacionamiento 24 horas - Purban",
      "address": "Jirón Lampa 787, Jiron Puno 309, Cercado de Lima 15001",
      "slotsQuantity": 10,
      "isAvailable": true,
      "ruc": "20549500553",
      "birthday": null,
      "description": "El mejor lugar para guardar tu auto, se ofrecen servicios varios como lavado y limpiado premium de lunas",
      "email": null,
      "password": null,
      "imageUrl":"https://www.econizeclosets.com/garage/garage-organization-company-northern-virginia.jpg"
    },
    {
      "id": 4,
      "fullName": "Playa de Estacionamiento Mano Poderosa de Cristo",
      "address": "Calle Faustino Sánchez Carrión 173 (Ex. Jr. Justo A. Vigil)",
      "slotsQuantity": 15,
      "isAvailable": false,
      "ruc": "20100098041",
      "birthday": null,
      "description": "Lugar amplio con servicio de lavado y pintado de autos chicos.",
      "email": null,
      "password": null,
      "imageUrl":null
    },
    {
      "id": 5,
      "fullName": "Playa de Estacionamiento 24 horas - Purban",
      "address": "Jirón Lampa 787, Jiron Puno 309, Cercado de Lima 15001",
      "slotsQuantity": 10,
      "isAvailable": true,
      "ruc": "20549500553",
      "birthday": null,
      "description": "El mejor lugar para guardar tu auto, se ofrecen servicios varios como lavado y limpiado premium de lunas",
      "email": null,
      "password": null,
      "imageUrl":"https://thereluctantbiker.files.wordpress.com/2010/12/img_1961.jpg"
    },
    {
      "id": 6,
      "fullName": "Playa de Estacionamiento Mano Poderosa de Cristo",
      "address": "Calle Faustino Sánchez Carrión 173 (Ex. Jr. Justo A. Vigil)",
      "slotsQuantity": 15,
      "isAvailable": false,
      "ruc": "20100098041",
      "birthday": null,
      "description": "Lugar amplio con servicio de lavado y pintado de autos chicos.",
      "email": null,
      "password": null,
      "imageUrl":"https://www.steeltechsheds.co.uk/wp-content/gallery/garages-2017/26ft-x-17ft-garage.jpg"
    }
  ],
  "totalResults": 6,
  "code": 200
}
""".data(using: .utf8)

