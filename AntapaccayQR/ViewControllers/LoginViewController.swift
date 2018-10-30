//
//  LoginViewController.swift
//  AntapaccayQR
//
//  Created by Innnovacis SRL on 30/10/18.
//  Copyright © 2018 Innnovacis SRL. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    @IBOutlet weak var userLoginVC: UITextField!
    override func viewDidLoad() {
        saveUser(user: userLoginVC)
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    func saveUser(user: UITextField!) -> String {
        if (user.text == ""){
            print("Hacer una alerta")
            return ""
        }
        else{
            print("Esta Guardado Data")
            return user.text!
        }
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
