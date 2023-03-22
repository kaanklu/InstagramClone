//
//  SettingsViewController.swift
//  InstaClone3
//
//  Created by Kaan Kalaycıoğlu on 9.03.2023.
//

import UIKit
import FirebaseAuth

class SettingsViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    @IBAction func logoutClicked(_ sender: Any) {
        
        do {
            try Auth.auth().signOut()
            
        }catch {
            print("error")
        }
            performSegue(withIdentifier: "toLoginScreen", sender: nil)
        
    }
    
}
