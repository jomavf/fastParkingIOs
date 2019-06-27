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
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var availabilityLabel: UILabel!
    @IBOutlet weak var fullnameLabel: UILabel!
    @IBOutlet weak var availabilityImageView: UIImageView!
    @IBOutlet weak var distanceLabel: UILabel!
    @IBOutlet weak var startLabel: UILabel!
    
    
    
    func update(owner:Owner){
        print("ESTE ES MI PUTO OWNER: ",owner)
        //Control availability
        if let isAvailable = owner.isAvailable {
            
            if isAvailable == true {
                availabilityLabel.text = "Disponible"
                availabilityImageView.image = UIImage(named: "check-home-16")
            } else {
                availabilityLabel.text = "No Disponible"
                availabilityImageView.image = UIImage(named: "wrong-home-16")
            }
        }
        //Control Image
        if let image = owner.imageUrl {
            mainImageView.setImageFrom(urlString: image, withDefaultNamed: "no-available", withErrorNamed: "no-available")
        }
        
        //Control fullname
        if let fullname = owner.fullName {
            fullnameLabel.text = fullname
        }
        
        //Control distance
        if let distance = owner.distance {
            distanceLabel.text = distance
        }
        
        // Price
        if let price = owner.price {
            priceLabel.text = "$\(price)"
        }
        
        // stars ....
        if let rating = owner.rating {
            startLabel.text = String(rating)
        }
        // Slots quantity
    }
}
