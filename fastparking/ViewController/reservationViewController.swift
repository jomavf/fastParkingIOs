//
//  reservationViewController.swift
//  fastparking
//
//  Created by Jose Veliz on 6/23/19.
//  Copyright © 2019 Jose Veliz. All rights reserved.
//

import UIKit

class reservationViewController: UIViewController {

    var object: Owner?
    
    @IBOutlet weak var startDateTimeInput: UITextField!
    @IBOutlet weak var endDateTimeInput: UITextField!
    
    private var startDatePicker: UIDatePicker?
    private var endDatePicker: UIDatePicker?
    @IBOutlet weak var priceLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // some change
        
        if let price = object?.price {
            priceLabel.text = "$FPP \(price)"
        }
        startDatePicker = UIDatePicker()
        endDatePicker = UIDatePicker()
        
        startDatePicker?.datePickerMode = .dateAndTime
        startDatePicker?.addTarget(self, action: #selector(reservationViewController.startDateChanged(startDatePicker:)), for: .valueChanged)
        
        endDatePicker?.datePickerMode = .dateAndTime
        endDatePicker?.addTarget(self, action: #selector(reservationViewController.endDateChanged(endDatePicker:)), for: .valueChanged)
        
        
        startDateTimeInput.inputView = startDatePicker
        endDateTimeInput.inputView = endDatePicker
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(reservationViewController.viewTapped(gestureRecognised:)))

        view.addGestureRecognizer(tapGesture)
        
        // Do any additional setup after loading the view.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let vc = segue.destination as? CongratsViewController
        if vc != nil {
            let owner = object
            vc!.object = owner
        }
    }
    
    @IBAction func buyButtonPressed(_ sender: Any) {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        // create context
        let context = appDelegate.persistentContainer.viewContext
        // create an entity and records
        guard let users = try! context.fetch(Users.fetchRequest()) as? [Users] else {return}
        print("Mi user: ", users[0].firstName!)// aqui el usuario supuestamente deberia estar
        // Aqui hacer la logica para restar puntos etc ya tengo el usuario arriba
        let id = Int(users[0].id)
        guard let owner = object else {return}
        let startDate = startDateTimeInput.text
        let endDate = endDateTimeInput.text
        let parameter = ["CustomerId":Int(id),"OwnerId":Int(owner.id),"StartReservationDate":startDate!,"EndReservationDate":endDate!] as [String : Any]
        print("URL: " ,fastParkingAPI.createReservationUrl(id))
        print("PARAMETERS: ",parameter)
        fastParkingAPI.postReservation(reservationId: id, parameter: parameter, responseHandler: responseHandler, errorHandler: errorHandler)
        
        //goTo
        self.performSegue(withIdentifier: "goToFinal", sender: self)
    }
    
    func responseHandler(data:ReservationResponse) {
        if data != nil {
            print("success")
            print(data)
        }
    }
    
    func errorHandler(error:Error) {
        print("ERROR IN",error)
    }
    
    
    
    @objc func viewTapped(gestureRecognised:UITapGestureRecognizer){
        view.endEditing(true)
    }
    
    @objc func startDateChanged(startDatePicker:UIDatePicker){
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm"
        startDateTimeInput.text = dateFormatter.string(from: startDatePicker.date)
        view.endEditing(true)
    }
    
    @objc func endDateChanged(endDatePicker:UIDatePicker){
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm"
        endDateTimeInput.text = dateFormatter.string(from: endDatePicker.date)
        view.endEditing(true)
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
