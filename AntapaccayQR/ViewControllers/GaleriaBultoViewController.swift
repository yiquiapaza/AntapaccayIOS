//
//  GaleriaBultoViewController.swift
//  AntapaccayQR
//
//  Created by Innnovacis SRL on 11/26/18.
//  Copyright © 2018 Innnovacis SRL. All rights reserved.
//

import UIKit
import Alamofire

class GaleriaBultoViewController: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate {

    @IBOutlet weak var imageView: UIImageView!
    let imagenSelect = UIImagePickerController()
    
    override func viewDidLoad() {
        //self.deleteDirectory()
       // self.getDirectoryPath()
        self.imagenSelect.delegate = self
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
            self.imageView.image = pickImage
            let imagenData = pickImage.pngData()
            saveImageDocumentDirectory(image: pickImage, imageName: "antapaccay" + String(CONTADOR_IMAGEN) + ".png")
            LISTA_PALETA.append(imagenData!)
            for item in LISTA_PALETA{
                print(item)
            }
            dismiss(animated: true, completion: nil)
            CONTADOR_IMAGEN = CONTADOR_IMAGEN + 1
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

    func convertImageTobase64(image:UIImage) -> String? {
        var imageData: Data?
        imageData = image.pngData()
        return imageData?.base64EncodedString()
    }

    func getDirectoryPath() -> Void {
        //let path = (NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as NSString).appendingPathComponent("Antapaccay")
        //let url = NSURL(string: path)
        //print(url)
        //return url!
    }
    func saveImageDocumentDirectory(image: UIImage, imageName: String) {
        let fileManager = FileManager.default
        let path = (NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as NSString).appendingPathComponent("Antapaccay")
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
    
    func deleteDirectory() {
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
}
