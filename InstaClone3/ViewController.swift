//
//  ViewController.swift
//  InstaClone3
//
//  Created by Kaan Kalaycıoğlu on 9.03.2023.
//

import UIKit
import FirebaseAuth

class ViewController: UIViewController {

    @IBOutlet weak var pwTF: UITextField!
    @IBOutlet weak var mailTF: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func loginClicked(_ sender: Any) {
        if pwTF.text != "" && mailTF.text != "" {
            Auth.auth().signIn(withEmail: mailTF.text!, password: pwTF.text!) { authdata, error in
                if error != nil {
                    self.makeAlert(titleInput: "Error", messegeInput: error!.localizedDescription)
                }
                else {
                    self.performSegue(withIdentifier: "toTabbar", sender: nil)
                }
            }
        }
        else {
            makeAlert(titleInput: "Error", messegeInput: "Please insert your email and password")
        }
    }
    
    @IBAction func registerClicked(_ sender: Any) {
        
        Auth.auth().createUser(withEmail: mailTF.text!, password: pwTF.text!) { authdata, error in
            if error != nil {
                self.makeAlert(titleInput: "Error", messegeInput: error?.localizedDescription ?? "error")
            }
            else {
                self.performSegue(withIdentifier: "toTabbar", sender: nil)
            }
        }
        
    }
    func makeAlert(titleInput : String, messegeInput : String) {
        let alert = UIAlertController(title: titleInput, message: messegeInput, preferredStyle: UIAlertController.Style.alert)
        let okButton = UIAlertAction(title: "error", style: UIAlertAction.Style.default)
        alert.addAction(okButton)
        self.present(alert, animated: true)
    }
}

