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
    var user:Users?
    
    @IBOutlet weak var startDateTimeInput: UITextField!
    @IBOutlet weak var endDateTimeInput: UITextField!
    
    @IBOutlet weak var cost: UILabel!
    private var startDatePicker: UIDatePicker?
    private var endDatePicker: UIDatePicker?
    @IBOutlet weak var priceLabel: UILabel!
    var finalPrice:Double = 0
    var dispatchGroup = DispatchGroup()
    
//    override func viewWillAppear(_ animated: Bool) {
//
//        let appDelegate = UIApplication.shared.delegate as! AppDelegate
//        // create context
//        let context = appDelegate.persistentContainer.viewContext
//        // create an entity and records
//
//        if let users = try! context.fetch(Users.fetchRequest()) as? [Users] {
//            user = users.last!
//        }
//        print("Mi ultimo usuario es: ",user!.email!,user!.password!)
//        let parameters = ["Email":user!.email!,"Password":user!.password!]
//        dispatchGroup.enter()
//        fastParkingAPI.loginRequest(parameter: parameters, responseHandler: responseHandler2, errorHandler: errorHandler2)
//
//        cost.text = "Costo $FPP 0"
//    }
    func responseHandler2(response: LoginResponse) {
        if response != nil {
            print("el response que hago ni bien entra la funcion ->",response)
            user?.totalAmount = Int32(response.customer!.totalAmount!)
            dispatchGroup.leave()
        }
    }
    func errorHandler2(error:Error){
        print("Error requiesting login: ",error)
        dispatchGroup.leave()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        // create context
        let context = appDelegate.persistentContainer.viewContext
        // create an entity and records
        
        if let users = try! context.fetch(Users.fetchRequest()) as? [Users] {
            user = users.last!
        }
        print("Mi ultimo usuario es: ","vf@gmail.com","123456")
        let parameters = ["Email":"vf@gmail.com","Password":"123456"]
        dispatchGroup.enter()
        fastParkingAPI.loginRequest(parameter: parameters, responseHandler: responseHandler2, errorHandler: errorHandler2)
        // some change
        dispatchGroup.notify(queue: .main) {
            self.cost.text = "Costo $FPP 0"
            if let price = self.object?.price {
                self.finalPrice = price
                self.priceLabel.text = "$FPP \(self.user!.totalAmount)"
            }
            self.startDatePicker = UIDatePicker()
            self.endDatePicker = UIDatePicker()
            
            self.startDatePicker?.datePickerMode = .dateAndTime
            self.startDatePicker?.addTarget(self, action: #selector(reservationViewController.startDateChanged(startDatePicker:)), for: .valueChanged)
            
            self.endDatePicker?.datePickerMode = .dateAndTime
            self.endDatePicker?.addTarget(self, action: #selector(reservationViewController.endDateChanged(endDatePicker:)), for: .valueChanged)
            
            
            self.startDateTimeInput.inputView = self.startDatePicker
            self.endDateTimeInput.inputView = self.endDatePicker
            
            let tapGesture = UITapGestureRecognizer(target: self, action: #selector(reservationViewController.viewTapped(gestureRecognised:)))
            
            self.view.addGestureRecognizer(tapGesture)
        }
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
        // Aqui hacer la logica para restar puntos etc ya tengo el usuario arriba
        let user = users[0]
        let id = Int(user.id)
        guard let owner = object else {return}
        let startDate = startDateTimeInput.text
        let endDate = endDateTimeInput.text
        
        let parameter = ["CustomerId":Int(id),"OwnerId":Int(owner.id),"StartReservationDate":startDate!,"EndReservationDate":endDate!,"Price":finalPrice] as [String : Any]
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
        cost.text = "Costo: $FPP \(finalPrice)"
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
