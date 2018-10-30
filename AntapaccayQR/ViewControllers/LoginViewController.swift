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
    @IBOutlet weak var passLoginVC: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func rememberLoginVC(_ sender: Any) {
    }
    @IBAction func loginLoginVC(_ sender: Any) {
        if (!userLoginVC.text!.isEmpty && !passLoginVC.text!.isEmpty){
            print("estoy aca")
            print(userLoginVC.text)
        }
        if(!userLoginVC.text!.isEmpty && passLoginVC.text!.isEmpty) {
            let alertUser = UIAlertController(title: "Ingrese Usuario", message: "El usuario es un campo Obligatorio", preferredStyle: UIAlertControllerStyle.alert)
            let exit = UIAlertAction(title: "Regresar", style: UIAlertActionStyle.cancel, handler: nil)
            alertUser.addAction(exit)
            
            self.present(alertUser, animated: true, completion: nil)
        }
        if(userLoginVC.text!.isEmpty && !passLoginVC.text!.isEmpty) {
            let alertPass = UIAlertController(title: "Ingrese Contraseña", message: "La contraseña es un campo Obligatorio", preferredStyle: UIAlertControllerStyle.alert)
            let exit = UIAlertAction(title: "Regresar", style: UIAlertActionStyle.cancel, handler: nil)
            alertPass.addAction(exit)
            
            self.present(alertPass, animated: true, completion: nil)
        }
        if(userLoginVC.text!.isEmpty && passLoginVC.text!.isEmpty) {
            let alertPass = UIAlertController(title: "Ingrese el Usuario y Contraseña", message: "Ambos son campos Obligatorios", preferredStyle: UIAlertControllerStyle.alert)
            let exit = UIAlertAction(title: "Regresar", style: UIAlertActionStyle.cancel, handler: nil)
            alertPass.addAction(exit)
            
            self.present(alertPass, animated: true, completion: nil)
        }
    }

}
