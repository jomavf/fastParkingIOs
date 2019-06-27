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
    
    var dispatchGroup = DispatchGroup()
    
    var owners: [Owner] = [Owner]()
    
    var currentRow = 0
    
    @IBOutlet weak var loading: UIActivityIndicatorView!
    @IBOutlet weak var colView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("executing viewDidLoad")
        colView.delegate = self
        colView.dataSource = self
        dispatchGroup.enter()
        fastParkingAPI.getOwners(responseHandler: responseHandler, errorHandler: errorHandler)
        dispatchGroup.notify(queue: .main) {
            self.loading.stopAnimating()
            self.loading.isHidden = true
            self.colView.isHidden = false
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        print("executing viewWillAppear")
        loading.startAnimating()
        loading.isHidden = false
        colView.isHidden = true
        
        if owners.count > 0 {
            self.colView.reloadItems(at: [IndexPath(item: currentRow, section: 0)])
            self.loading.stopAnimating()
            self.loading.isHidden = true
            self.colView.isHidden = false
        }
    }
    
    func responseHandler(data:OwnerResponse) {
        if data.owners != nil {
            self.owners = data.owners!
            self.colView.reloadData()
            dispatchGroup.leave()
        } else {
            print("No data or problems with responseHandler function")
            dispatchGroup.leave()
        }
    }
    
    func errorHandler(error:Error) {
        let message="Error on sources request: \(error.localizedDescription)"
        print(message)
        dispatchGroup.leave()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let vc = segue.destination as? DetailsViewController
        if vc != nil {
            vc!.object = self.owners[currentRow]
        }
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return owners.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "LocalCell", for: indexPath) as!OwnerCollectionViewCell
        cell.update(owner: owners[indexPath.row] )
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        currentRow = indexPath.item
        performSegue(withIdentifier: "showDetail", sender: self)
    }

}
