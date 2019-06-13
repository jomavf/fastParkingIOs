//
//  LoginViewController.swift
//  fastparking
//
//  Created by Jose Veliz on 6/7/19.
//  Copyright © 2019 Jose Veliz. All rights reserved.
//

import UIKit
import SwiftKeychainWrapper

class LoginViewController: UIViewController {

//    let semaphore = DispatchSemaphore(value: 0)
    let dispatchGroup = DispatchGroup()
    var isCustomer:Bool?
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func loginTapped(_ sender: Any) {
        let mainStoryBoard = UIStoryboard(name: "Main", bundle: Bundle.main)
        guard let email = emailTextField.text,let password = passwordTextField.text else { return }
        if email.trimmingCharacters(in: .whitespacesAndNewlines) == "" || password.trimmingCharacters(in: .whitespacesAndNewlines) == "" {
            createAlert(title: "Error", message: "Complete los campos usuario y contraseña porfavor")
            return
        }
        dispatchGroup.enter()
        requestLogin(email,password)
        
        dispatchGroup.notify(queue: .main) {
            if self.isLogin() {
                if self.isCustomer == true {
                    if let tabbar = (mainStoryBoard.instantiateViewController(withIdentifier: "tabbar") as? UITabBarController) {
                        self.present(tabbar, animated: true, completion: nil)
                    }
                } else {
                    if let tabbarOwner = (mainStoryBoard.instantiateViewController(withIdentifier: "tabbarOwner") as? UITabBarController) {
                        self.present(tabbarOwner, animated: true, completion: nil)
                    }
                }
                
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
    
    func requestLogin(_ email:String,_ password:String) {
        let parameters = ["Email":email,"Password":password]
        fastParkingAPI.loginRequest(parameter: parameters, responseHandler: responseHandler, errorHandler: errorHandler)
    }
    
    func responseHandler(response: LoginResponse) {
        if let _ = response.customer {
            isCustomer = true // es customer
        }
        else {
            isCustomer = false // es owner
        }
        if let token = response.token {
            let _: Bool = KeychainWrapper.standard.set(token, forKey: "token")
            dispatchGroup.leave()
        } else {
            createAlert(title: "Error", message: "Credenciales incorrectas")
            dispatchGroup.leave()
        }
    }
    
    func errorHandler(error:Error) {
        print("Error while requesting info. : ",error)
    }
    
    func isLogin() -> Bool {
        let retrievedString: String? = KeychainWrapper.standard.string(forKey: "token")
        guard let _ = retrievedString else {
            return false
        }
        return true
    }

}
