//
//  NacionaliadViewController.swift
//  AntapaccayQR
//
//  Created by Innnovacis SRL on 11/7/18.
//  Copyright © 2018 Innnovacis SRL. All rights reserved.
//

import UIKit

class NacionaliadViewController: UIViewController {

    @IBOutlet weak var nacionalidad: UISwitch!
    @IBOutlet weak var internacional: UISwitch!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    @IBAction func nacionalSwitch(_ sender: UISwitch) {
        if sender.isOn {
            self.internacional.setOn(false, animated: true)
            NACIONAL = true
            IMPORTACION = false
        }
        else {
            IMPORTACION = false
            NACIONAL = false
        }
    }

    @IBAction func internacionalSwitch(_ sender: UISwitch) {
        if sender.isOn {
            self.nacionalidad.setOn(false, animated: true)
            IMPORTACION = true
            NACIONAL = false
        }
        else {
            IMPORTACION = false
            NACIONAL = false
        }
    }
    
    @IBAction func pesoIntro(_ sender: UITextField) {
        PESO = sender.text!
    }
    
    @IBAction func altoIntro(_ sender: UITextField) {
        ALTO = sender.text!
    }
    
    @IBAction func anchoIntro(_ sender: UITextField) {
        ANCHO = sender.text!
    }
    
    @IBAction func largoIntro(_ sender: UITextField) {
        LARGO = sender.text!
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
