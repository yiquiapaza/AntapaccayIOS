//
//  TipoViewController.swift
//  AntapaccayQR
//
//  Created by Innnovacis SRL on 11/7/18.
//  Copyright © 2018 Innnovacis SRL. All rights reserved.
//

import UIKit

class TipoViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    @IBAction func fragilSwitch(_ sender: UISwitch) {
        if sender.isOn {
            FRAGIL = true
        }
        else {
            FRAGIL = false
        }
    }
    
    @IBAction func sobreDimension(_ sender: UISwitch) {
        if sender.isOn {
            SOBREDIMENSIONADO = true
        }
        else
        {
            SOBREDIMENSIONADO = false
        }
    }
    
    @IBAction func cargaPeligrosa(_ sender: UISwitch) {
        if sender.isOn {
            CARGA_PELIGROSA = true
        }
        else{
            CARGA_PELIGROSA = false
        }
    }
    
    @IBAction func general(_ sender: UISwitch) {
        if sender.isOn {
            GENERAL = true
        }
        else{
            GENERAL = false
        }
    }
    
    @IBAction func componente(_ sender: UISwitch) {
        if sender.isOn {
            COMPONENTE = true
        }
        else {
            COMPONENTE = false
        }
    }
    
    @IBAction func unidadCompleta(_ sender: UISwitch) {
        if sender.isOn {
            UNIDAD_COMPLETA = true
        }
        else {
            UNIDAD_COMPLETA = false
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
