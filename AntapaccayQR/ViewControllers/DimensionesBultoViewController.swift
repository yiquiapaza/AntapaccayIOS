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
    
}
