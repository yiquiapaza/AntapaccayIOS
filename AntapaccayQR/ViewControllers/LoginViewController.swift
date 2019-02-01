//
//  LoginViewController.swift
//  AntapaccayQR
//
//  Created by Innnovacis SRL on 30/10/18.
//  Copyright © 2018 Innnovacis SRL. All rights reserved.
//

import UIKit
import Alamofire
import SwiftSpinner
import PMAlertController

class LoginViewController: UIViewController, UITextFieldDelegate {
    
    var user = Array<User>()
    
    @IBOutlet var viewLogin: UIView!
    @IBOutlet weak var imagenLogin: UIImageView!
    @IBOutlet weak var buttonLogin: UIButton!
    @IBOutlet weak var switchIntro: UISwitch!
    @IBOutlet weak var labelLogin: UILabel!
    var estado : Bool = false
    
    @IBOutlet weak var userLoginVC: UITextField!
    @IBOutlet weak var passLoginVC: UITextField!
    
    override func viewDidLoad() {
        roundTexField(text: userLoginVC)
        roundTexField(text: passLoginVC)
        roundTexField(text: buttonLogin)
        imageViewIntro(image: imagenLogin)
        startView(vistaIntro: viewLogin)
        passLoginVC.delegate = self
        super.viewDidLoad()
        if (UserDefaults.standard.string(forKey: "user") != VACIO && UserDefaults.standard.string(forKey: "pass") != VACIO){
            DispatchQueue.main.asyncAfter(deadline: .now()) {
                self.performSegue(withIdentifier: SESSION_SEGUE, sender: self)
            }
        }
    }
    
    @IBAction func rememberLoginVC(_ sender: UISwitch) {
        if ( sender.isOn == true ){
            UserDefaults.standard.set(userLoginVC.text, forKey: "user")
            UserDefaults.standard.set(userLoginVC.text, forKey: "pass")
        }
        else if (sender.isOn == false ){
            UserDefaults.standard.set(VACIO, forKey: "user")
            UserDefaults.standard.set(VACIO, forKey: "pass")
        }
    }
    @IBAction func loginLoginVC(_ sender: Any) {
        if (!userLoginVC.text!.isEmpty && !passLoginVC.text!.isEmpty){
            delay(seconds: 0.0, completion: {
                SwiftSpinner.show("Verificando al Usuario")
                let parameters : Parameters = [
                    "UserName": self.userLoginVC.text!,
                    "Password": self.passLoginVC.text!,
                    "RememberMe": ""
                ]
                Alamofire.request(LOGIN_USER, method: .post, parameters: parameters, encoding: JSONEncoding.default)
                .responseJSON(){
                    response in switch response.result{
                    case .success(let data):
                        let out = data as! Dictionary<String,AnyObject>
                        if out.isEmpty {
                            let alertOrden = PMAlertController(title: "Error", description: "El Usuario o la Contraseña estan erroneas", image: UIImage(named: "error"), style: .alert)
                            alertOrden.addAction(PMAlertAction(title: "Aceptar", style: .cancel))
                            self.present(alertOrden, animated: true, completion: nil)
                            SwiftSpinner.hide()
                        }
                        else {
                            let alertOrden = PMAlertController(title: "Exito", description: "Bienvenido", image: UIImage(named: "exito"), style: .alert)
                            alertOrden.addAction(PMAlertAction(title: "Aceptar", style: .cancel))
                            SwiftSpinner.hide()
                            let rol = out["Roles"] as! [Dictionary<String, Any>]
                            print(rol)
                            UserDefaults.standard.set( rol[0]["RoleName"] as! String,forKey:"rol" )
                            //self.present(alertOrden, animated: true, completion: nil)
                            DispatchQueue.main.asyncAfter(deadline: .now()) {
                                self.performSegue(withIdentifier: SESSION_SEGUE, sender: self)
                            }
                        }
                        print(data)
                    case .failure(let error):
                        print(error)
                        SwiftSpinner.hide()
                        let datos = PMAlertController(title: "Error", description: "Verifique los datos ingresados y su conneccion a Internet", image: UIImage(named: "error"), style: .alert)
                        datos.addAction(PMAlertAction(title: "Aceptar", style: .cancel))
                        self.present(datos, animated: true, completion: nil)
                    }
                }
            })
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

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        passLoginVC.resignFirstResponder()
        return true
    }
    
    func delay(seconds: Double, completion: @escaping () -> ()) {
        let popTime = DispatchTime.now() + Double(Int64( Double(NSEC_PER_SEC) * seconds )) / Double(NSEC_PER_SEC)
        
        DispatchQueue.main.asyncAfter(deadline: popTime) {
            completion()
        }
    }
    
}
