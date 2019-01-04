//
//  GaleriaBultoViewController.swift
//  AntapaccayQR
//
//  Created by Innnovacis SRL on 11/26/18.
//  Copyright © 2018 Innnovacis SRL. All rights reserved.
//

import UIKit

class GaleriaBultoViewController: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate {

    @IBOutlet weak var imageView: UIImageView!
    let imagenSelect = UIImagePickerController()
    
    override func viewDidLoad() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Cerrar Session", style: .plain, target: self, action: #selector(cerrarSession))
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        super.viewDidLoad()

        // Do any additional setup after loading the view.
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
        imagenSelect.allowsEditing = false
        imagenSelect.sourceType = .photoLibrary
        present(imagenSelect, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let pickImage = info[.originalImage] as? UIImage{
            print("Imagen Found")
            print(pickImage)
        }
        else {
            print("no se puede ")
        }
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }

    @objc func cerrarSession(){
        UserDefaults.standard.set(VACIO, forKey: "user")
        UserDefaults.standard.set(VACIO, forKey: "pass")
        let loginView = self.storyboard?.instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController
        present(loginView, animated: true, completion: nil)
    }

}
