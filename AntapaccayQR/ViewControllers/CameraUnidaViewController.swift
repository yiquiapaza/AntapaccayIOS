//
//  CameraUnidaViewController.swift
//  AntapaccayQR
//
//  Created by Innnovacis SRL on 12/18/18.
//  Copyright © 2018 Innnovacis SRL. All rights reserved.
//

import UIKit

class CameraUnidaViewController: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate  {

    
    @IBOutlet weak var imagen: UIImageView!
    let imagenSelect = UIImagePickerController()
    
    override func viewDidLoad() {
        self.imagenSelect.delegate = self
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Cerrar Session", style: .plain, target: self, action: #selector(cerrarSession))
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        super.viewDidLoad()

    }

    @IBAction func verGaleria(_ sender: UIButton) {
        imagenSelect.allowsEditing = false
        imagenSelect.sourceType = .photoLibrary
        present(imagenSelect, animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
         dismiss(animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let pickImage = info[.originalImage] as? UIImage{
            print("Imagen Found")
            print(pickImage)
            self.imagen.image = pickImage
            let imagenData = pickImage.pngData()
            saveImageDocumentDirectory(image: pickImage, imageName: "antapaccay3" + String(CONTADOR_IMAGEN_3) + ".png")
            LISTA_PALETA.append(imagenData!)
            for item in LISTA_PALETA{
                print(item)
            }
            dismiss(animated: true, completion: nil)
            CONTADOR_IMAGEN_3 = CONTADOR_IMAGEN_3 + 1
        }
        else {
            print("no se puede ")
        }
    }
    
    @objc func cerrarSession(){
        UserDefaults.standard.set(VACIO, forKey: "user")
        UserDefaults.standard.set(VACIO, forKey: "pass")
        let loginView = self.storyboard?.instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController
        present(loginView, animated: true, completion: nil)
    }

    func saveImageDocumentDirectory(image: UIImage, imageName: String) {
        let fileManager = FileManager.default
        let path = (NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as NSString).appendingPathComponent("Antapaccay3")
        if !fileManager.fileExists(atPath: path) {
            try! fileManager.createDirectory(atPath: path, withIntermediateDirectories: true, attributes: nil)
        }
        let url = NSURL(string: path)
        let imagePath = url!.appendingPathComponent(imageName)
        let urlString: String = imagePath!.absoluteString
        let imageData = image.pngData()
        //let imageData = UIImagePNGRepresentation(image)
        fileManager.createFile(atPath: urlString as String, contents: imageData, attributes: nil)
    }
}
