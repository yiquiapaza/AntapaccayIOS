//
//  QRViewController.swift
//  AntapaccayQR
//
//  Created by Innnovacis SRL on 11/10/18.
//  Copyright © 2018 Innnovacis SRL. All rights reserved.
//

import UIKit
import QRCoder

class QRViewController: UIViewController {

    @IBOutlet weak var s: UIImageView!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        let generador = QRCodeGenerator()
        s.image = generador.createImage(value: "Dende Puto",size: CGSize(width: 200, height: 200))
        // Do any additional setup after loading the view.
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
