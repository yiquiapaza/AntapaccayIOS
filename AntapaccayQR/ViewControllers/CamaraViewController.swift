//
//  CamaraViewController.swift
//  AntapaccayQR
//
//  Created by Innnovacis SRL on 11/7/18.
//  Copyright © 2018 Innnovacis SRL. All rights reserved.
//

import UIKit
import AVFoundation
import Photos

class CamaraViewController: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate{
    
    @IBOutlet weak var imageView: UIImageView!
    let imagenSelect = UIImagePickerController()
    
    override func viewDidLoad() {
        checkPermission()
        super.viewDidLoad()
        imagenSelect.delegate = self
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Cerrar Session", style: .plain, target: self, action: #selector(cerrarSession))
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        
    }
    
    @IBAction func openCameraButton(sender: AnyObject) {
        
        let vs = UIImagePickerController()
        vs.sourceType = .camera
        vs.allowsEditing = true
        vs.delegate = self
        present(vs, animated: true)
        //let picker = UIImagePickerController()
        //picker.delegate = (self as! UIImagePickerControllerDelegate & UINavigationControllerDelegate)
        //picker.sourceType = .camera
        //present(picker, animated: true, completion: nil)
        
        print("the camera was accessed")
    }

    @IBAction func selectImagen(_ sender: UIButton) {
        checkPermission()
        imagenSelect.allowsEditing = false
        imagenSelect.sourceType = .photoLibrary
        imagenSelect.mediaTypes = UIImagePickerController.availableMediaTypes(for: .photoLibrary)!
        present(imagenSelect, animated: true, completion: nil)
    }
    
    @objc func cerrarSession(){
        UserDefaults.standard.set(VACIO, forKey: "user")
        UserDefaults.standard.set(VACIO, forKey: "pass")
        let loginView = self.storyboard?.instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController
        present(loginView, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let pickImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage{
            print("Imagen Found")
            print(pickImage)
            self.imageView.contentMode = .scaleToFill
            self.imageView.image = pickImage
            dismiss(animated: true, completion: nil)
        }
        else {
            print("no se puede ")
        }
    }
    
    func checkPermission() {
        let photoAuthorizationStatus = PHPhotoLibrary.authorizationStatus()
        switch photoAuthorizationStatus {
        case .authorized:
            print("Access is granted by user")
        case .notDetermined:
            PHPhotoLibrary.requestAuthorization({
                (newStatus) in
                print("status is \(newStatus)")
                if newStatus ==  PHAuthorizationStatus.authorized {
                    /* do stuff here */
                    print("success")
                }
            })
            print("It is not determined until now")
        case .restricted:
            // same same
            print("User do not have access to photo album.")
        case .denied:
            // same same
            print("User has denied the permission.")
        }
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
}
