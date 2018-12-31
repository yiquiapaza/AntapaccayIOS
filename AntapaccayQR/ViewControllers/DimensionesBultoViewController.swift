//
//  DimensionesBultoViewController.swift
//  AntapaccayQR
//
//  Created by Innnovacis SRL on 11/26/18.
//  Copyright © 2018 Innnovacis SRL. All rights reserved.
//

import UIKit

class DimensionesBultoViewController: UIViewController {
    
    override func viewDidLoad() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Cerrar Session", style: .plain, target: self, action: #selector(cerrarSession))
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        super.viewDidLoad()
    }
    
    @IBAction func pesoAction(_ sender: UITextField) {
        PESO_BULTO = sender.text!
    }
    @IBAction func altoAction(_ sender: UITextField) {
        ALTO_BULTO = sender.text!
    }
    @IBAction func anchoAction(_ sender: UITextField) {
        ANCHO_BULTO = sender.text!
    }
    @IBAction func largoAction(_ sender: UITextField) {
        LARGO_BULTO = sender.text!
    }
    
    @objc func cerrarSession(){
        UserDefaults.standard.set(VACIO, forKey: "user")
        UserDefaults.standard.set(VACIO, forKey: "pass")
    }
    
}
