//
//  CreateOwnerViewController.swift
//  fastparking
//
//  Created by Jose Veliz on 6/12/19.
//  Copyright © 2019 Jose Veliz. All rights reserved.
//

import UIKit

class CreateOwnerViewController: UIViewController {
    let dispatchGroup = DispatchGroup()
    
//    @IBOutlet weak var nameField: UITextField!
//    @IBOutlet weak var slotsQuantityField: UITextField!
//    @IBOutlet weak var descriptionField: UITextField!
//    @IBOutlet weak var rucField: UITextField!
//    @IBOutlet weak var addressField: UITextField!
    
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var addressField: UITextField!
    @IBOutlet weak var rucField: UITextField!
    @IBOutlet weak var descriptionField: UITextField!
    @IBOutlet weak var slotsQuantityField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    @IBAction func saveButtonTapped(_ sender: Any) {
        let mainStoryBoard = UIStoryboard(name: "Main", bundle: Bundle.main)
        guard let name = nameField.text,
            let address = addressField.text,
            let email = emailField.text,
            let password = passwordField.text,
            let ruc = rucField.text,
            let description = descriptionField.text,
            let slotsQuantity = slotsQuantityField.text else {createAlert(title: "Error", message: "Complete todos los campos porfavor")
                return
        }
        if name.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
            email.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
            password.trimmingCharacters(in: .whitespacesAndNewlines) == "" || ruc.trimmingCharacters(in: .whitespacesAndNewlines) == "" || description.trimmingCharacters(in: .whitespacesAndNewlines) == "" || address.trimmingCharacters(in: .whitespacesAndNewlines) == "" {
            createAlert(title: "Error", message: "Complete todos los campos")
            return
        }
        guard let sQuantity = Int(slotsQuantity) else {
            createAlert(title: "Error", message: "El campo de slots tiene que ser numerico")
            return
        }
        dispatchGroup.enter()
        requestLogin(name, address, description, email, password, ruc, Int(sQuantity), "to do", -12.041572, -77.03382)
        
        dispatchGroup.notify(queue: .main) {
            if let loginViewController = (mainStoryBoard.instantiateViewController(withIdentifier: "LoginViewController") as? LoginViewController) {
                self.present(loginViewController, animated: true, completion: nil)
            }
        }
    }
    func createAlert(title: String,message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let ok = UIAlertAction(title: "OK", style: .default) { action in }
        alert.addAction(ok)
        DispatchQueue.main.async {
            self.present(alert,animated: true)
        }
    }
    
    func requestLogin(_ name:String,_ address:String,_ description: String,_ email: String,_ password: String,_ ruc:String,_ slotsQuantity:Int,_ urlImage:String,_ latitude:Double,_ longitude: Double) {
        let parameters = ["FullName":name,"Address":address,"Birthday":"2012-06-02", "Password":password,"Description":description,"Email":email,"Ruc":ruc,"SlotsQuantity":slotsQuantity,"UrlImage":urlImage,"Latitude":latitude,"Longitude":longitude] as [String : Any]
        fastParkingAPI.postOwners(parameter: parameters, responseHandler: responseHandler, errorHandler: errorHandler)
    }
    
    func responseHandler(response: PostOwnerResponse) {
        dispatchGroup.leave()
    }
    
    func errorHandler(error:Error) {
        print("Error while requesting info. : ",error)
        dispatchGroup.leave()
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
