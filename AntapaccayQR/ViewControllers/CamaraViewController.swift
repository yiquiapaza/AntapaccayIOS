//
//  CamaraViewController.swift
//  AntapaccayQR
//
//  Created by Innnovacis SRL on 11/7/18.
//  Copyright © 2018 Innnovacis SRL. All rights reserved.
//

import UIKit
import AVFoundation
//import QRCoder
import QRCodeScannerFramework

class CamaraViewController: UIViewController {
//class CamaraViewController: QRCodeScannerViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //cv.qrScannerDelegate = self
        // Do any additional setup after loading the view.
    }
  
    //override func processQRCodeContent(qrCodeContent: String) -> Bool {
    //    print(qrCodeContent)
    //    dismiss(animated: true, completion: nil)
    //    return true
    //}
    
    @IBOutlet weak var resultado: UILabel!
    
    //let cv = QRScannerController()
    
    

    @IBAction func back(_ sender: Any) {
        //dismiss(animated: true, completion: nil)
        //self.navigationController?.pushViewController(cv, animated: true)
        
    }
}
//extension CamaraViewController : QrScannerDelegate{
//    func getScannedData(data: String) {
//        resultado.text = data
//    }
//}

