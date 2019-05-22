//
//  OwnerViewController.swift
//  fastparking
//
//  Created by Jose Veliz on 5/22/19.
//  Copyright © 2019 Jose Veliz. All rights reserved.
//

import UIKit

class OwnerViewController: UIViewController,UICollectionViewDataSource,UICollectionViewDelegate {
    
    var owners: [Owner] = []
    
    @IBOutlet weak var colView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        colView.delegate = self
        colView.dataSource = self
        loadOwners()
        self.colView.reloadData()
        // Do any additional setup after loading the view.
    }
    
    func loadOwners()->Void {
        let ownerDecoder = JSONDecoder()
        do {
            let ownerResult = try ownerDecoder.decode(OwnerResponse.self, from: ownerResponse!)
            owners = ownerResult.owners!
        }
        catch {
            print("Failed to load owners: \(error.localizedDescription)")
        }
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return owners.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as!HomeCollectionViewCell
        
        // Configure the cell
        let selectedOwner = owners[indexPath.row]
        cell.update(owner: selectedOwner )
        return cell
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
