//
//  ListReservationCollectionViewController.swift
//  fastparking
//
//  Created by Jose Veliz on 6/25/19.
//  Copyright © 2019 Jose Veliz. All rights reserved.
//

import UIKit

private let reuseIdentifier = "ReservationCell"

class ListReservationCollectionViewController: UIViewController,UICollectionViewDataSource,UICollectionViewDelegate {
    
    @IBOutlet weak var collecView: UICollectionView!
    
    var dispatchGroup = DispatchGroup()
    var reservations: [Reservation] = [Reservation]()
    var currentRow = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        
        collecView.delegate = self
        collecView.dataSource = self
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Register cell classes
//        self.collectionView!.register(UICollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        
        // Do any additional setup after loading the view.
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        // create context
        let context = appDelegate.persistentContainer.viewContext
        // create an entity and records
        guard let users = try! context.fetch(Users.fetchRequest()) as? [Users] else {return}
        print("Mi user: ", users[0].firstName!)// aqui el usuario supuestamente deberia estar
        // Aqui hacer la logica para restar puntos etc ya tengo el usuario arriba
        let id = Int(users[0].id)
        dispatchGroup.enter()
        fastParkingAPI.getReservation(reservationId: id, responseHandler: responseHandler, errorHandler: errorHandler)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
//        let appDelegate = UIApplication.shared.delegate as! AppDelegate
//        // create context
//        let context = appDelegate.persistentContainer.viewContext
//        // create an entity and records
//        guard let users = try! context.fetch(Users.fetchRequest()) as? [Users] else {return}
//        print("Mi user: ", users[0].firstName!)// aqui el usuario supuestamente deberia estar
//        // Aqui hacer la logica para restar puntos etc ya tengo el usuario arriba
//        let id = Int(users[0].id)
//        dispatchGroup.enter()
//        fastParkingAPI.getReservation(reservationId: id, responseHandler: responseHandler, errorHandler: errorHandler)
//
    }
    
    func responseHandler(data:ReservationResponse) {
        if data.reservations != nil {
            print("success")
            self.reservations = data.reservations!
            print(data.reservations!)
            self.collecView.reloadData()
            dispatchGroup.leave()
        } else {
            print("ORROR")
        }
    }
    
    func errorHandler(error:Error) {
        print("ERROR IN",error)
        dispatchGroup.leave()
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

    // MARK: UICollectionViewDataSource

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }


    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return reservations.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        print("entre0")
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! ReservationCollectionViewCell
        cell.update(reservation: reservations[indexPath.row])
        // Configure the cell
        print("entre1")
        return cell
    }
    
//    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        currentRow = indexPath.item
////        performSegue(withIdentifier: "showDetail", sender: self)
//    }
    

}
