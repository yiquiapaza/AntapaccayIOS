//
//  ViewController.swift
//  AntapaccayQR
//
//  Created by Innnovacis SRL on 29/10/18.
//  Copyright © 2018 Innnovacis SRL. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet var viewIntro: UIView!
    @IBOutlet weak var imageIntro: UIImageView!
    @IBOutlet weak var labelIntro: UILabel!
    override func viewDidLoad() {
        imageViewIntro(image: imageIntro)
        startView(vistaIntro: viewIntro)
        
        super.viewDidLoad()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            self.performSegue(withIdentifier: LOGIN_SEGEN, sender: self)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func startView(vistaIntro:UIView) -> Void {
        let layer = CAGradientLayer()
        layer.frame = vistaIntro.bounds
        layer.colors = [UIColor(red:1.00, green:0.60, blue:0.20, alpha:1.0).cgColor,UIColor(red:0.82, green:0.27, blue:0.27, alpha:1.0).cgColor]
        layer.startPoint = CGPoint(x: 0, y: 0)
        layer.endPoint = CGPoint(x: 1, y: 1)
        vistaIntro.layer.addSublayer(layer)
        vistaIntro.addSubview(imageIntro)
        vistaIntro.addSubview(labelIntro)
    }
    func imageViewIntro(image: UIImageView) -> Void {
        image.image = UIImage(imageLiteralResourceName: "logo")
        image.layer.masksToBounds = false
        image.layer.borderColor = UIColor.white.cgColor
        image.clipsToBounds = true
    }
}

