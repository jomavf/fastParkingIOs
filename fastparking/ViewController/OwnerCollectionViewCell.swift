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
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var slotsLabel: UILabel!
    
    func update(owner:Owner){
        mainImageView.image = UIImage(named: "no-available")
        availabilityLabel.layer.masksToBounds = true
        availabilityLabel.layer.cornerRadius = 6
        if owner.isAvailable! {
            availabilityLabel.layer.backgroundColor = UIColor.blue.cgColor
            availabilityLabel.text = "Disponible"
        } else {
            availabilityLabel.layer.backgroundColor = UIColor.red.cgColor
            availabilityLabel.text = "No Disponible"
        }
        if owner.urlImage != nil {
            mainImageView.setImageFrom(urlString: owner.urlImage!, withDefaultNamed: "no-available", withErrorNamed: "no-available")
        }
        fullNameLabel.text = owner.fullName!
        if let description = owner.description {
            descriptionLabel.text = description
        }
        
        priceLabel.text = "$\(11) per hour"
        slotsLabel.text = "Slots: \(String(owner.slotsQuantity!))"
    }
}
