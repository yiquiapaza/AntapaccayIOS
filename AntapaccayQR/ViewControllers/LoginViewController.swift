//
//  LoginViewController.swift
//  AntapaccayQR
//
//  Created by Innnovacis SRL on 30/10/18.
//  Copyright © 2018 Innnovacis SRL. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
    
    @IBOutlet var viewLogin: UIView!
    @IBOutlet weak var imagenLogin: UIImageView!
    @IBOutlet weak var buttonLogin: UIButton!
    @IBOutlet weak var switchIntro: UISwitch!
    @IBOutlet weak var labelLogin: UILabel!
    
    @IBOutlet weak var userLoginVC: UITextField!
    @IBOutlet weak var passLoginVC: UITextField!
    
    override func viewDidLoad() {
        roundTexField(text: userLoginVC)
        roundTexField(text: passLoginVC)
        roundTexField(text: buttonLogin)
        imageViewIntro(image: imagenLogin)
        startView(vistaIntro: viewLogin)
        super.viewDidLoad()
    }
    
    @IBAction func rememberLoginVC(_ sender: Any) {
    }
    @IBAction func loginLoginVC(_ sender: Any) {
        if (!userLoginVC.text!.isEmpty && !passLoginVC.text!.isEmpty){
            //print("estoy aca")
            //Cuando este el Login
            //print(userLoginVC.text)
        }
        if(!userLoginVC.text!.isEmpty && passLoginVC.text!.isEmpty) {
            let alertUser = UIAlertController(title: "Ingrese Usuario", message: "El usuario es un campo Obligatorio", preferredStyle: UIAlertController.Style.alert)
            let exit = UIAlertAction(title: "Regresar", style: UIAlertAction.Style.cancel, handler: nil)
            alertUser.addAction(exit)
            
            self.present(alertUser, animated: true, completion: nil)
        }
        if(userLoginVC.text!.isEmpty && !passLoginVC.text!.isEmpty) {
            let alertPass = UIAlertController(title: "Ingrese Contraseña", message: "La contraseña es un campo Obligatorio", preferredStyle: UIAlertController.Style.alert)
            let exit = UIAlertAction(title: "Regresar", style: UIAlertAction.Style.cancel, handler: nil)
            alertPass.addAction(exit)
            
            self.present(alertPass, animated: true, completion: nil)
        }
        if(userLoginVC.text!.isEmpty && passLoginVC.text!.isEmpty) {
            let alertPass = UIAlertController(title: "Ingrese el Usuario y Contraseña", message: "Ambos son campos Obligatorios", preferredStyle: UIAlertController.Style.alert)
            let exit = UIAlertAction(title: "Regresar", style: UIAlertAction.Style.cancel, handler: nil)
            alertPass.addAction(exit)
            
            self.present(alertPass, animated: true, completion: nil)
        }
    }
    
    func startView(vistaIntro:UIView) -> Void {
        let layer = CAGradientLayer()
        layer.frame = vistaIntro.bounds
        layer.colors = [UIColor(red:1.00, green:0.60, blue:0.20, alpha:1.0).cgColor,UIColor(red:0.82, green:0.27, blue:0.27, alpha:1.0).cgColor]
        layer.startPoint = CGPoint(x: 0, y: 0)
        layer.endPoint = CGPoint(x: 1, y: 1)
        vistaIntro.layer.addSublayer(layer)
        vistaIntro.addSubview(imagenLogin)
        vistaIntro.addSubview(userLoginVC)
        vistaIntro.addSubview(passLoginVC)
        vistaIntro.addSubview(buttonLogin)
        vistaIntro.addSubview(switchIntro)
        vistaIntro.addSubview(labelLogin)
        //vistaIntro.addSubview(labelIntro)
    }
    func imageViewIntro(image: UIImageView) -> Void {
        image.image = UIImage(imageLiteralResourceName: "logo")
        image.layer.masksToBounds = false
        image.layer.borderColor = UIColor.white.cgColor
        image.clipsToBounds = true
    }
    
    func roundTexField(text: UIView) -> Void {
        text.layer.masksToBounds = true
        text.layer.cornerRadius = 25
        text.layer.borderWidth = 0.5
        text.layer.borderColor = UIColor.red.cgColor
    }

}
