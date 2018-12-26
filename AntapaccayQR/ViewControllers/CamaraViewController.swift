//
//  CamaraViewController.swift
//  AntapaccayQR
//
//  Created by Innnovacis SRL on 11/7/18.
//  Copyright © 2018 Innnovacis SRL. All rights reserved.
//

import UIKit
import AVFoundation


class CamaraViewController: UIViewController{
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imageView.image = UIImage(named: "error")
    }
    
    @IBOutlet weak var imageView: UIImageView!

    
    @IBAction func openCameraButton(sender: AnyObject) {
        let picker = UIImagePickerController()
        picker.delegate = (self as! UIImagePickerControllerDelegate & UINavigationControllerDelegate)
        picker.sourceType = .camera
        present(picker, animated: true, completion: nil)
        
        print("the camera was accessed")
    }

}
