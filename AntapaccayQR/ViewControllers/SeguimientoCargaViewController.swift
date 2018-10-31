//
//  SeguimientoCargaViewController.swift
//  AntapaccayQR
//
//  Created by Innnovacis SRL on 10/31/18.
//  Copyright © 2018 Innnovacis SRL. All rights reserved.
//

import UIKit
import DropDown

class SeguimientoCargaViewController: UIViewController {

 
    @IBOutlet var prueba: UIView!
    let nuevo = DropDown()
    var nuevo2 = Orden(_valorOrden: "M43401", _tipoOrden: "OC", _idComprador: "", _codigoDistrito: "XTAN", _priceCode: "")
    
    
    @IBAction func menu(_ sender: Any) {
        ObtenerOrdenDet(_parametros: nuevo2)
        nuevo.anchorView = prueba
        nuevo.dataSource = ["Car", "Motorcycle", "Truck"]
        nuevo.show()
    }
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

}

