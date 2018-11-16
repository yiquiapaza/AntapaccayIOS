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

    var shouldHideNavBar = false
    
    @IBOutlet weak var s: UIImageView!
    var id_qr_code:String = ""
    
    @IBOutlet weak var id: UILabel!
    
    override func viewDidLoad() {
        self.navigationController?.isNavigationBarHidden = true
        super.viewDidLoad()
        let generador = QRCodeGenerator()
        s.image = generador.createImage(value: "B:" + self.id_qr_code,size: CGSize(width: 355, height: 355))
        id.text = "ID: " + self.id_qr_code
        // Do any additional setup after loading the view.
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = false
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(shouldHideNavBar, animated: animated)
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
