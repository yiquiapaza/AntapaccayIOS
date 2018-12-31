//
//  QRViewController.swift
//  AntapaccayQR
//
//  Created by Innnovacis SRL on 11/10/18.
//  Copyright © 2018 Innnovacis SRL. All rights reserved.
//

import UIKit

class QRViewController: UIViewController {

    var shouldHideNavBar = false
    
    @IBOutlet weak var s: UIImageView!
    var id_qr_code:String = ""
    var imagePrint: UIImage = UIImage()
    
    var nuevoData: Data = Data()
    
    @IBOutlet weak var id: UILabel!
    
    override func viewDidLoad() {
        self.navigationController?.isNavigationBarHidden = true
        super.viewDidLoad()
        navigationItem.leftBarButtonItem     = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Cerrar Sesion", style: .plain, target: nil, action: #selector(cerrarSession))
        //let generador = QRCodeGenerator()
        //s.image = generador.createImage(value: "B:" + self.id_qr_code,size: CGSize(width: 355, height: 355))
        //imagePrint = generador.createImage(value: "B:" + self.id_qr_code, size: CGSize(width: 10, height: 10))!
        s.image = generatorQRCode(from: "B: " + self.id_qr_code)
        id.text = "ID: " + self.id_qr_code
        //createDirectory(image: self.s.image!)
        
        // Do any additional setup after loading the view.
    }
    
    func generatorQRCode(from string:String) -> UIImage? {
        let data = string.data(using: String.Encoding.ascii)
        
        if let filter = CIFilter(name: "CIQRCodeGenerator"){
            filter.setValue(data, forKey: "inputMessage")
            let transform = CGAffineTransform(scaleX: 3, y: 3 )
            if let output = filter.outputImage?.transformed(by: transform){
                return UIImage(ciImage: output)
            }
        }
        
        return nil
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = false
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(shouldHideNavBar, animated: animated)
    }
    
    
    @IBAction func imprimir(_ sender: Any) {
        //let image = URL(self.s.data,nil)
        
       // if UIPrintInteractionController.canPrint(){
            
       // }
            
        let printController = UIPrintInteractionController.shared
        // 2
        let printInfo = UIPrintInfo(dictionary:nil)
        printInfo.jobName = "print Job"
        printInfo.outputType =  .general
        printController.printInfo = printInfo
        

        
        // 3
        //let nuevo = UISimpleTextPrintFormatter()
        //nuevo.perPageContentInsets = UIEdgeInsets(top: 72, left: 72, bottom: 72, right: 72)
        //printController.printFormatter = nuevo
        printController.printingItem = self.s.image
        // 4
        printController.present(animated: true, completionHandler: nil)
    }

    func createDirectory(image:UIImage) -> Void {
        let mainPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0]
        print(mainPath)
        let qrcodeDirectoryPath = mainPath + "qrcode"
        var ojeCtBool:ObjCBool = true
        
        let isExit = FileManager.default.fileExists(atPath: qrcodeDirectoryPath, isDirectory: &ojeCtBool)
        
        if isExit == false {
            do {
                try FileManager.default.createDirectory(atPath: qrcodeDirectoryPath, withIntermediateDirectories: true, attributes: nil)
            }catch{
                print("Error")
            }
        }
    }
    
    @IBAction func backMenu(_ sender: UIButton) {
        let menuViewController = storyboard?.instantiateViewController(withIdentifier: "MenuViewController") as! MenuViewController
        navigationController?.pushViewController( menuViewController, animated: true)
    }
    @objc func cerrarSession(){
        UserDefaults.standard.set(VACIO, forKey: "user")
        UserDefaults.standard.set(VACIO, forKey: "pass")
        let loginView = self.storyboard?.instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController
        present(loginView, animated: true, completion: nil)
    }
}
