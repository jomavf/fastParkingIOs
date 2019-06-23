//
//  RegisterCustomerViewController.swift
//  fastparking
//
//  Created by Jose Veliz on 6/12/19.
//  Copyright © 2019 Jose Veliz. All rights reserved.
//

import UIKit

class RegisterCustomerViewController: UIViewController {
    
    let dispatchGroup = DispatchGroup()
    
    @IBOutlet weak var firstnameField: UITextField!
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func createAccountTapped(_ sender: Any) {
        let mainStoryBoard = UIStoryboard(name: "Main", bundle: Bundle.main)
        guard let fullname = firstnameField.text,
        let email = emailField.text,
            let password = passwordField.text else {return}
        if fullname.trimmingCharacters(in: .whitespacesAndNewlines) == "" || email.trimmingCharacters(in: .whitespacesAndNewlines) == "" || password.trimmingCharacters(in: .whitespacesAndNewlines) == "" {
            createAlert(title: "Error", message: "Complete los campos porfavor")
            return
        }
        dispatchGroup.enter()
        requestRegisterCustomer(fullname,email,password)
        
        
        dispatchGroup.notify(queue: .main) {
            if let loginViewController = (mainStoryBoard.instantiateViewController(withIdentifier: "LoginViewController") as? LoginViewController) {
                self.present(loginViewController, animated: true, completion: nil)
            }
        }
    }
    
    func requestRegisterCustomer(_ fullName:String,_ email:String,_ password:String) {
        let parameters = ["FirstName":"gg","LastName":"gg","Birthday":"1996-05-25","Email":email,"Password":password,"Dni":"666","FullName":fullName]
        fastParkingAPI.postCustomer(parameter: parameters, responseHandler: responseHandler, errorHandler: errorHandler)
    }
    
    func createAlert(title: String,message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let ok = UIAlertAction(title: "OK", style: .default) { action in }
        alert.addAction(ok)
        DispatchQueue.main.async {
            self.present(alert,animated: true)
        }
    }
    
    func responseHandler(response: CustomerResponse) {
//        print(response)
        dispatchGroup.leave()
    }
    
    func errorHandler(error:Error) {
        print("Error while requesting info. : ",error)
        dispatchGroup.leave()
    }

}
