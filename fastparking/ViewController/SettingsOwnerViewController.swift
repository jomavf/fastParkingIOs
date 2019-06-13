//
//  SettingsOwnerViewController.swift
//  fastparking
//
//  Created by Jose Veliz on 6/12/19.
//  Copyright © 2019 Jose Veliz. All rights reserved.
//

import UIKit
import SwiftKeychainWrapper

class SettingsOwnerViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func signoutTapped(_ sender: Any) {
        let mainStoryBoard = UIStoryboard.init(name: "Main", bundle: Bundle.main)
        if let loginViewController = (mainStoryBoard.instantiateViewController(withIdentifier: "LoginViewController") as? LoginViewController) {
            self.present(loginViewController, animated: true, completion: clearToken)
        }
    }
    func clearToken() {
        let _: Bool = KeychainWrapper.standard.removeObject(forKey: "token")
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
