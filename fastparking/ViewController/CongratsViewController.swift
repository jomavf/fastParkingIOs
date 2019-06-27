//
//  CongratsViewController.swift
//  fastparking
//
//  Created by Jose Veliz on 6/27/19.
//  Copyright © 2019 Jose Veliz. All rights reserved.
//

import UIKit

class CongratsViewController: UIViewController {

    var object:Owner?
    
    @IBOutlet weak var priceLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        print(object)
        if let price = object?.price {
            priceLabel.text = "$FPP \(price)"
        } else {
            print("NO OWNER FOUND ON FINAL FUCK!")
        }
 
        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
