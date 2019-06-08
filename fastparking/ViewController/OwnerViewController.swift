//
//  OwnerViewController.swift
//  fastparking
//
//  Created by Jose Veliz on 5/22/19.
//  Copyright © 2019 Jose Veliz. All rights reserved.
//

import UIKit
import Alamofire

class OwnerViewController: UIViewController,UICollectionViewDataSource,UICollectionViewDelegate {
    
    var owners: [Owner] = []
    
    @IBOutlet weak var colView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        colView.delegate = self
        colView.dataSource = self
        fastParkingAPI.getOwners(responseHandler: responseHandler, errorHandler: errorHandler)
        self.colView.reloadData()
    }
    
    func responseHandler(data:OwnerResponse) {
        if data.owners != nil {
            self.owners = data.owners!
            self.colView.reloadData()
        } else {
            print("No data or problems with responseHandler function")
        }
    }
    
    func errorHandler(error:Error) {
        let message="Error on sources request: \(error.localizedDescription)"
        print(message)
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return owners.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as!OwnerCollectionViewCell
        
        // Configure the cell
        let selectedOwner = owners[indexPath.row]
        cell.update(owner: selectedOwner )
        return cell
    }

}
