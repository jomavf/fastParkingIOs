//
//  SettingsViewController.swift
//  fastparking
//
//  Created by Jose Veliz on 6/8/19.
//  Copyright © 2019 Jose Veliz. All rights reserved.
//

import UIKit
import SwiftKeychainWrapper

class SettingsViewController: UIViewController {

    @IBAction func goToLogin(_ sender: Any) {
        let mainStoryBoard = UIStoryboard.init(name: "Main", bundle: Bundle.main)
        if let loginViewController = (mainStoryBoard.instantiateViewController(withIdentifier: "LoginViewController") as? LoginViewController) {
            self.present(loginViewController, animated: true, completion: clearToken)
        }
    }
    
    func clearToken() {
        let _: Bool = KeychainWrapper.standard.removeObject(forKey: "token")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

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
