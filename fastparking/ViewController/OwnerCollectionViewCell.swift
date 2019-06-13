//
//  HomeCollectionViewCell.swift
//  fastparking
//
//  Created by Jose Veliz on 5/21/19.
//  Copyright © 2019 Jose Veliz. All rights reserved.
//

import UIKit

class OwnerCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var mainImageView: UIImageView!
    @IBOutlet weak var availabilityLabel: UILabel!
    @IBOutlet weak var fullNameLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    
    func update(owner:Owner){
        mainImageView.image = UIImage(named: "no-available")
        guard let isAvailable = owner.isAvailable else {
            availabilityLabel.text = "No Disponible"
            return
        }
        if isAvailable {
            availabilityLabel.text = "Disponible"
        } else {
            availabilityLabel.text = "No Disponible"
        }
        if owner.imageUrl != nil {
            mainImageView.setImageFrom(urlString: owner.imageUrl!, withDefaultNamed: "no-available", withErrorNamed: "no-available")
        }
        fullNameLabel.text = owner.fullName!
        priceLabel.text = "$\(11) per hour"
    }
}
