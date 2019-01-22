//
//  MenuViewController.swift
//  AntapaccayQR
//
//  Created by Innnovacis SRL on 10/30/18.
//  Copyright © 2018 Innnovacis SRL. All rights reserved.
//

import UIKit

class MenuViewController: UIViewController {

    @IBOutlet var menuView: UIView!
    @IBOutlet weak var viewItemMenu: UIView!
    @IBOutlet weak var imagenMenu: UIImageView!
    @IBOutlet weak var userMenu: UILabel!
    @IBOutlet weak var correoMenu: UILabel!
    
    override func viewDidLoad() {
        self.deleteDirectoryGuia()
        self.deleteDirectoryAntapaccay1()
        self.deleteDirectoryAntapaccay2()
        self.deleteDirectoryAntapaccay3()
        CONTADOR_IMAGEN = 0
        CONTADOR_IMAGEN_2 = 0
        CONTADOR_IMAGEN_3 = 0
        imageViewIntro(image: imagenMenu)
        startView(vistaIntro: menuView)
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    func startView(vistaIntro:UIView) -> Void {
        let layer = CAGradientLayer()
        layer.frame = vistaIntro.bounds
        layer.colors = [UIColor(red:1.00, green:0.60, blue:0.20, alpha:1.0).cgColor,UIColor(red:0.82, green:0.27, blue:0.27, alpha:1.0).cgColor]
        layer.startPoint = CGPoint(x: 0, y: 0)
        layer.endPoint = CGPoint(x: 1, y: 1)
        vistaIntro.layer.addSublayer(layer)
        vistaIntro.addSubview(viewItemMenu)
        vistaIntro.addSubview(imagenMenu)
        vistaIntro.addSubview(userMenu)
        vistaIntro.addSubview(correoMenu)
    }
    
    func imageViewIntro(image: UIImageView) -> Void {
        image.image = UIImage(imageLiteralResourceName: "logo")
        image.layer.masksToBounds = false
        image.layer.borderColor = UIColor.white.cgColor
        image.clipsToBounds = true
    }
    
    func deleteDirectoryGuia() {
        let fileManager = FileManager.default
        let yourProjectImagesPath = (NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as NSString).appendingPathComponent("AntapaccayGuia")
        if fileManager.fileExists(atPath: yourProjectImagesPath) {
            try! fileManager.removeItem(atPath: yourProjectImagesPath)
        }
        let yourProjectDirectoryPath = (NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as NSString).appendingPathComponent("AntapaccayGuia")
        if fileManager.fileExists(atPath: yourProjectDirectoryPath) {
            try! fileManager.removeItem(atPath: yourProjectDirectoryPath)
        }
    }
    func deleteDirectoryAntapaccay1() {
        let fileManager = FileManager.default
        let yourProjectImagesPath = (NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as NSString).appendingPathComponent("Antapaccay")
        if fileManager.fileExists(atPath: yourProjectImagesPath) {
            try! fileManager.removeItem(atPath: yourProjectImagesPath)
        }
        let yourProjectDirectoryPath = (NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as NSString).appendingPathComponent("Antapaccay")
        if fileManager.fileExists(atPath: yourProjectDirectoryPath) {
            try! fileManager.removeItem(atPath: yourProjectDirectoryPath)
        }
    }
    func deleteDirectoryAntapaccay2() {
        let fileManager = FileManager.default
        let yourProjectImagesPath = (NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as NSString).appendingPathComponent("Antapaccay_2")
        if fileManager.fileExists(atPath: yourProjectImagesPath) {
            try! fileManager.removeItem(atPath: yourProjectImagesPath)
        }
        let yourProjectDirectoryPath = (NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as NSString).appendingPathComponent("Antapaccay_2")
        if fileManager.fileExists(atPath: yourProjectDirectoryPath) {
            try! fileManager.removeItem(atPath: yourProjectDirectoryPath)
        }
    }
    func deleteDirectoryAntapaccay3() {
        let fileManager = FileManager.default
        let yourProjectImagesPath = (NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as NSString).appendingPathComponent("Antapaccay3")
        if fileManager.fileExists(atPath: yourProjectImagesPath) {
            try! fileManager.removeItem(atPath: yourProjectImagesPath)
        }
        let yourProjectDirectoryPath = (NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as NSString).appendingPathComponent("Antapaccay3")
        if fileManager.fileExists(atPath: yourProjectDirectoryPath) {
            try! fileManager.removeItem(atPath: yourProjectDirectoryPath)
        }
    }
}
