//
//  ReservationCollectionViewCell.swift
//  fastparking
//
//  Created by Jose Veliz on 6/25/19.
//  Copyright © 2019 Jose Veliz. All rights reserved.
//

import UIKit

class ReservationCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var ownerFullname: UILabel!
    @IBOutlet weak var startDate: UILabel!
    @IBOutlet weak var endDate: UILabel!
    @IBOutlet weak var mainImage: UIImageView!
    
    func update(reservation:Reservation){
        guard let fullname = reservation.owner?.fullName, let dateStart = reservation.startReservationDate,
            let dateEnd = reservation.endReservationDate,
            let image = reservation.owner?.imageUrl else {
                return
        }
        ownerFullname.text = fullname
        startDate.text = dateEnd
        endDate.text = dateStart
        mainImage.setImageFrom(urlString: image, withDefaultNamed: "no-available", withErrorNamed: "no-available")
    }
}
