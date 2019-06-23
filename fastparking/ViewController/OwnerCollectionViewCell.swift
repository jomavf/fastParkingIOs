//
//  HomeCollectionViewCell.swift
//  fastparking
//
//  Created by Jose Veliz on 5/21/19.
//  Copyright © 2019 Jose Veliz. All rights reserved.
//

import UIKit

class OwnerCollectionViewCell: UICollectionViewCell {
    
//    @IBOutlet weak var mainImageView: UIImageView!
//    @IBOutlet weak var availabilityLabel: UILabel!
//    @IBOutlet weak var fullNameLabel: UILabel!
//    @IBOutlet weak var priceLabel: UILabel!
    
    @IBOutlet weak var mainImageView: UIImageView!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var availabilityLabel: UILabel!
    @IBOutlet weak var fullnameLabel: UILabel!
    @IBOutlet weak var availabilityImageView: UIImageView!
    @IBOutlet weak var distanceLabel: UILabel!
    
    
    
    func update(owner:Owner){
        print("OWNER: ",owner)
        
        guard let isAvailable = owner.isAvailable,
            let fullname = owner.fullName,
            let image = owner.imageUrl,
            let distance = owner.distance else {
            //aqui es que es nulo el atributo
            return
        }
        
        //Control availability
        if isAvailable == true {
            availabilityLabel.text = "Disponible"
            availabilityImageView.image = UIImage(named: "available24")
        } else if isAvailable == false {
            availabilityLabel.text = "No Disponible"
            availabilityImageView.image = UIImage(named: "no-available24")
        }
        // image
        mainImageView.setImageFrom(urlString: image, withDefaultNamed: "no-available", withErrorNamed: "no-available")
        // fullname
        fullnameLabel.text = fullname
        //distance
        distanceLabel.text = distance
        
        //TODO:
        // price
        priceLabel.text = "$\(11)"
        // stars ....
        // Slots quantity
    }
}
